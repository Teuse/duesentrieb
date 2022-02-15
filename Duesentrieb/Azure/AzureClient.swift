import Foundation
import Combine

struct AzureClient {
    private var cancelBag = CancelBag()
    
    private let azUrl = "https://vssps.dev.azure.com/"
    
    let urlSession: URLSession
    let token: String
    let organization: String
    let header: RestClient.Header
    
    var baseUrl: String { "\(azUrl)/\(organization)" }
    
    init(session: URLSession, organization: String, token: String) {
        self.urlSession = session
        self.token = token
        self.organization = organization
        self.header = AzureClient.createHeader(token: token)
    }
    
    private static func createHeader(token: String) -> RestClient.Header {
        let token64 = token.toBase64()
        let header: RestClient.Header = [
            "Content-Type"    : "application/json",
            "Authorization"   : "token \(token64)",
        ]
        return header
    }
}

extension AzureClient {
    
    func fetchOrganizations() -> AnyPublisher<[AzOrganization], BackendError> {
        let url = URL(string: "\(baseUrl)/_apis/projects?stateFilter=All&api-version=1.0")!
        
        let result: AnyPublisher<AzOrganizationContainer, BackendError> = RestClient.modelForRequest(method: .get, url: url, header: header, session: urlSession)
        return result
            .map{ return $0.value }
            .eraseToAnyPublisher()
    }

    func fetchProject(id: String) -> AnyPublisher<[AzRepository], BackendError> {
        let url = URL(string: "\(baseUrl)/\(id)/_apis/git/repositories?api-version=6.0")!
        
        let result: AnyPublisher<AzRepositoryContainer, BackendError> = RestClient.modelForRequest(method: .get, url: url, header: header, session: urlSession)
        return result
            .map{ return $0.value }
            .eraseToAnyPublisher()
    }
}
