import SwiftUI
import Combine

enum ConnectionState {
    case idle
    case connecting
    case error(String)
}

class RootViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    
    @Published private(set) var connectionState = ConnectionState.idle
    @Published private(set) var gitViewModels: [GithubViewModel] = []
    
    var numberOfOpenPullRequests: Int {
        return gitViewModels.map{ $0.numberOfOpenPullRequests }.reduce(0, +)
    }
    var numberOfOpenReviewRequests: Int {
        return gitViewModels.map{ $0.numberOfOpenReviewRequests }.reduce(0, +)
    }
    var hasConnectionIssue: Bool {
        return gitViewModels.contains(where: { $0.requestState == .error })
    }
    
    //MARK:- Life Circle
    
    init() {}
    
    //MARK:- Public Functions
    
    func reconnect() {
        guard gitViewModels.isEmpty else { return assertionFailure("Only reconnect, if not connected to a service already!") }
        
//        if let url = AppSettings.githubUrl, let token = AppSettings.githubToken {
//            connectViewModel = ConnectViewModel() { serviceConnection in
//            self.connect(ServiceConnection)
//        }
//        connectViewModel.connectToGithub()

//        let user = User(login: "testuser", email: "testuser@blub.de")
//        let client = GithubClient(url: URL(string: "https://bla.de")!, token: "blub")
//        connected(service: ServiceConnection(type: .github, user: user, repositories: [Repository](), client: client))
    }
    
    func connected(service: ServiceConnection) {
        let viewModel = GithubViewModel(user: service.user, repositories: service.repositories, client: service.client)
        gitViewModels.append(viewModel)
        AppSettings.githubUrl = service.client.url
        AppSettings.githubToken = service.client.token
    }
    
    func disconnect(uuid: UUID) {
        gitViewModels.removeAll(where: { $0.uuid == uuid })
        AppSettings.githubUrl = nil
        AppSettings.githubToken = nil
    }
    
    func triggerUpdate() {
        gitViewModels.forEach{ $0.updateViewModel() }
    }
    
    func clickQuitApp() {
        NSApplication.shared.terminate(nil)
    }
}

extension RootViewModel {
    
    func doesConnectionExists(to url: URL, token: String) -> Bool {
        return gitViewModels.contains(where: { $0.url == url && $0.token == token })
    }
    
    func connectToGithub(gitUrl: String, token: String) {
        if case .connecting = connectionState { return assertionFailure("Can't connect to multiple services simulateous!") }
        connectionState = .connecting
        
        guard let url = URL(string: gitUrl) else {
            connectionState = .error("Not a valid url.")
            return
        }
        
        guard !doesConnectionExists(to: url, token: token) else {
            connectionState = .error("Already connected to this github account.")
            return
        }
        
        let client = GithubClient(url: url, token: token)
        var user: User? = nil
        client.fetchUser()
            .flatMap{ fetchedUser -> AnyPublisher<[Repository], GithubError> in
                user = fetchedUser
                return GithubViewModel.fetchRepositories(client: client, user: fetchedUser)
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.connectionState = .error("Couldn't connect to service: \(error.localizedDescription)")
                } else {
                    self.connectionState = .idle
                }
            }, receiveValue: { repositories in
                guard let user = user else  { return assertionFailure() }
                let serviceConnection = ServiceConnection(type: .github, user: user, repositories: repositories, client: client)
                self.connected(service: serviceConnection)
            })
            .store(in: cancelBag)
    }
}
