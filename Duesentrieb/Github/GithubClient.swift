import Foundation
import Combine
import SwiftUI
import Apollo

enum GithubError: Error {
    case dataCorrupt
}

struct GithubClient {
    typealias HTTPHeader = [String : String]
    
    let url: URL
    let token: String
    private let apollo: ApolloClient
    
    init(url: URL, token: String) {
        self.url = url
        self.token = token
        self.apollo = GithubClient.createApolloClient(url: url, token: token)
    }
 
    func fetchState(completion: @escaping (User, [PullRequest])->(), error: @escaping (GithubError)->()) {
        apollo.fetch(query: StateQuery()) { result in
            guard let data = try? result.get().data, let pullRequestsNodes = data.viewer.pullRequests.nodes else { return error(.dataCorrupt) }
            let user = User(viewer: data.viewer)
            let pullRequests = pullRequestsNodes.compactMap {
                PullRequest(pullRequest: $0)
            }
            completion(user, pullRequests)
        }
    }
}

extension GithubClient {
    
    private static func createHeader(token: String) -> HTTPHeader {
        let header: HTTPHeader = [
            "Authorization"   : "token \(token)",
        ]
        return header
    }
    
    static func createApolloClient(url: URL, token: String) -> ApolloClient {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: createHeader(token: token))
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }
}
