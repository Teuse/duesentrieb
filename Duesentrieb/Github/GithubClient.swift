import Foundation
import Combine
import SwiftUI
import Apollo

enum GithubError: Error {
    case dataCorrupt
    case graphqlError
}

struct GithubClient {
    typealias HTTPHeader = [String : String]
    
    static let dateFormatter = ISO8601DateFormatter()
    
    let url: URL
    let token: String
    
    private let apollo: ApolloClient
    
    //MARK:- Life Circle
    
    init(url: URL, token: String) {
        self.url = url
        self.token = token
        self.apollo = GithubClient.createApolloClient(url: url, token: token)
    }
    
    //MARK:- Public Functions
    
    func fetchUser() -> AnyPublisher<User, GithubError> {
        let subject = PassthroughSubject<User, GithubError>()
        
        apollo.fetch(query: UserQuery()) { result in
            if let _ = try? result.get().errors {
                return subject.send(completion: .failure(.graphqlError))
            }
            guard let data = try? result.get().data else {
                return subject.send(completion: .failure(.dataCorrupt))
            }
            let user = User(qlViewer: data.viewer)
            subject.send(user)
            subject.send(completion: .finished)
        }
        return subject.eraseToAnyPublisher()
    }
    
    func fetchUserRepositories() -> AnyPublisher<[Repository], GithubError> {
        let subject = PassthroughSubject<[Repository], GithubError>()
        
        apollo.fetch(query: RepositoriesQuery()) { result in
            if let _ = try? result.get().errors {
                return subject.send(completion: .failure(.graphqlError))
            }
            guard let data = try? result.get().data, let qlRepos = data.viewer.repositories.nodes else {
                return subject.send(completion: .failure(.dataCorrupt))
            }
            let repositories = qlRepos.compactMap{ Repository(repo: $0) }
            subject.send(repositories)
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    func fetchOrgRepositories() -> AnyPublisher<[Repository], GithubError> {
        let subject = PassthroughSubject<[Repository], GithubError>()
        
        apollo.fetch(query: OrganizationsQuery(curser: nil)) { result in
            if let _ = try? result.get().errors {
                return subject.send(completion: .failure(.graphqlError))
            }
            guard let data = try? result.get().data, let qlOrgs = data.viewer.organizations.nodes else {
                return subject.send(completion: .failure(.dataCorrupt))
            }
            let repositories = flattenRepos(orgs: qlOrgs.compactMap{ $0 })
            subject.send(repositories)
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    private func flattenRepos(orgs: [OrganizationsQuery.Data.Viewer.Organization.Node]) -> [Repository] {
        //TODO: ugly hack. How to solve with map/flatMap/compactMap?
        var allRepos = [Repository]()
        for org in orgs {
            if let repoNodes = org.repositories.nodes {
                let repos = repoNodes.compactMap{ Repository(repo: $0) }
                allRepos.append(contentsOf: repos)
            }
        }
        return allRepos
    }
}

//MARK:- Clinent init helper

extension GithubClient {
    
    private static func createHeader(token: String) -> HTTPHeader {
        let header: HTTPHeader = [
            "Authorization"   : "token \(token)",
        ]
        return header
    }
    
    private static func createApolloClient(url: URL, token: String) -> ApolloClient {
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

//extension GithubClient {
//    
//    //    func test() {
//    //        var allRepos = [Repository]()
//    //        fetchOrgRepositories()
//    //            .flatMap{ reps, curser -> AnyPublisher<([Repository], String?), GithubError> in
//    //                allRepos.append(contentsOf: reps)
//    //                if let curser = curser {
//    //                    return fetchOrgRepositories(curser: curser)
//    //                }
//    //                Future<([Repository], String?), GithubError>(
//    //            }
//    //    }
//        
//        func recursive(curser: String?) -> AnyPublisher<([Repository], String?), GithubError> {
//            return fetchOrgRepositories2(curser: curser)
//                .flatMap{ reps -> AnyPublisher<([Repository], String?), GithubError> in
//                    if let curser = curser {
//                        return recursive(curser: curser)
//                    }
//                    PassthroughSubject<User, GithubError>()
//                    return Just<([Repository], String?), GithubError>((reps, blub))
//                        .eraseToAnyPublisher()
//                }
//                .eraseToAnyPublisher()
//        }
//        func fetchOrgRepositories2(curser: String? = nil) -> AnyPublisher<([Repository], String?), GithubError> {
//            let subject = PassthroughSubject<([Repository], String?), GithubError>()
//            
//            apollo.fetch(query: OrganizationsQuery(curser: nil)) { result in
//                if let _ = try? result.get().errors {
//                    return subject.send(completion: .failure(.graphqlError))
//                }
//                guard let data = try? result.get().data, let qlOrgs = data.viewer.organizations.nodes else {
//                    return subject.send(completion: .failure(.dataCorrupt))
//                }
//                let pageInfo = data.viewer.organizations.pageInfo
//                let curser = pageInfo.hasNextPage ? pageInfo.endCursor : nil
//                let repositories = flattenRepos(orgs: qlOrgs.compactMap{ $0 })
//                subject.send((repositories, curser))
//                subject.send(completion: .finished)
//            }
//            
//            return subject.eraseToAnyPublisher()
//        }
//}
