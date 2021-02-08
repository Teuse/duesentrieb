import Foundation
import Combine

struct GithubClient {
    private var cancelBag = CancelBag()
    let urlSession: URLSession
    let token: String
    let baseUrl: String
    let header: RestClient.Header
    
    init(session: URLSession, baseUrl: String, token: String) {
        self.urlSession = session
        self.token = token
        self.baseUrl = baseUrl
        self.header = GithubClient.createHeader(token: token)
    }
    
    private static func createHeader(token: String) -> RestClient.Header {
        let header: RestClient.Header = [
            "Content-Type"    : "application/json",
            "Authorization"   : "token \(token)",
        ]
        return header
    }
}

extension GithubClient {
    
    func loginUser() -> AnyPublisher<User, BackendError> {
        let url = URL(string: "\(baseUrl)/user")!
        return RestClient.modelForRequest(method: .get, url: url, header: header, session: urlSession)
    }
    
    func listOpenPRs(org: String, repo: String) -> AnyPublisher<[PullRequest], BackendError> {
        let url = URL(string: "\(baseUrl)/repos/\(org)/\(repo)/pulls?state=open")!
        return RestClient.arrayForRequest(method: .get, url: url, header: header, session: urlSession)
    }
    
    func reviews(org: String, repo: String, pr: Int) -> AnyPublisher<[Review], BackendError> {
        let url = URL(string: "\(baseUrl)/repos/\(org)/\(repo)/pulls/\(pr)/reviews")!
        return RestClient.arrayForRequest(method: .get, url: url, header: header, session: urlSession)
    }
}
