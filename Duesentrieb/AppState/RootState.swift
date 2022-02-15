import SwiftUI
import Combine

enum ConnectionState {
    case idle
    case connecting
    case error(String)
}

class RootState: ObservableObject {
    private var cancelBag = CancelBag()
    private var settings = AppSettings()
    
    @Published private(set) var connectionState = ConnectionState.idle
    @Published private(set) var gitStates: [GithubState] = []
    
    var appVersion: String { "\(settings.versionNumber).\(settings.buildNumber)" }
    
    var numberOfOpenPullRequests: Int {
        return gitStates.map{ $0.numberOfOpenPullRequests }.reduce(0, +)
    }
    var numberOfOpenReviewRequests: Int {
        return gitStates.map{ $0.numberOfOpenReviewRequests }.reduce(0, +)
    }
    var hasConnectionIssue: Bool {
        return gitStates.contains(where: { $0.requestState == .error })
    }
    
    //MARK:- Life Circle
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            print("Trigger Update")
            self.triggerUpdate()
        }
    }
    
    //MARK:- Public Functions
    
    func reconnect() {
        guard gitStates.isEmpty else { return assertionFailure("Only reconnect, if not connected to a service already!") }
        
        for service in settings.services {
            connectToGithub(gitUrl: service.url, token: service.token) {}
        }

//        let user = User(login: "testuser", email: "testuser@blub.de")
//        let client = GithubClient(url: "https://bla.de", token: "blub")
//        connected(service: ServiceConnection(type: .github, user: user, repositories: [Repository](), client: client))
    }
    
    func connected(connection: ServiceConnection) {
        let service = Service(type: .github, url: connection.client.url.absoluteString, token: connection.client.token)
        let githubState = GithubState(service: service, connection: connection)
        gitStates.append(githubState)
        settings.add(service: service)
    }
    
    func disconnect(service: Service) {
        gitStates.removeAll(where: { $0.service == service })
        settings.remove(service: service)
    }
    
    func triggerUpdate() {
        gitStates.forEach{ $0.updateViewModel() }
    }
    
    func clickQuitApp() {
        NSApplication.shared.terminate(nil)
    }
}

extension RootState {
    
    func doesConnectionExists(to url: URL, token: String) -> Bool {
        return gitStates.contains(where: { $0.url == url && $0.token == token })
    }
    
    func connectToGithub(gitUrl: String, token: String, callback: @escaping () -> Void) {
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
                return GithubState.fetchRepositories(client: client, user: fetchedUser)
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.connectionState = .error("Couldn't connect to service: \(error.localizedDescription)")
                    // reset the error state after 20 seconds
                    self.delayedErrorStateReset()
                    callback()
                }
            }, receiveValue: { repositories in
                guard let user = user else  { return assertionFailure() }
                let serviceConnection = ServiceConnection(type: .github, user: user, repositories: repositories, client: client)
                self.connected(connection: serviceConnection)
                self.connectionState = .idle
                callback()
            })
            .store(in: cancelBag)
    }
    
    private func delayedErrorStateReset() {
        Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { _ in
            if case .error(_) = self.connectionState {
                self.connectionState = .idle
            }
        }
    }
}
