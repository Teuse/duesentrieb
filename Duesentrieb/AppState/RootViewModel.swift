import SwiftUI
import Combine

//https://git.daimler.com/api/graphql

class RootViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    
    @Published private(set) var connectionState = RequestState.unknown
    @Published private(set) var gitViewModel: GithubViewModel?
    
    //MARK:- Life Circle
    
    init() {
        if let url = AppSettings.githubUrl, let token = AppSettings.githubToken {
            clickConnect(gitUrl: url, token: token)
        }
    }
    
    //MARK:- Public Functions
    
    func clickConnect(gitUrl: URL, token: String) {
        guard connectionState != .requesting else { return }
        connectionState = .requesting
     
        let client = GithubClient(url: gitUrl, token: token)
//        client.test()
        var user: User? = nil
        client.fetchUser()
            .flatMap{ fetchedUser -> AnyPublisher<[Repository], GithubError> in
                user = fetchedUser
                return GithubViewModel.fetchRepositories(client: client, user: fetchedUser)
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: Failed to fetch User: \(error.localizedDescription)")
                    self.connectionState = .error
                }
            }, receiveValue: { [weak self] repositories in
                guard let user = user else  { return assertionFailure() }
                self?.connect(user: user, repositories: repositories, client: client)
            })
            .store(in: cancelBag)
    }
    
    private func connect(user: User, repositories: [Repository], client: GithubClient) {
        gitViewModel = GithubViewModel(user: user, repositories: repositories, client: client)
        connectionState = .done
        AppSettings.githubUrl = client.url
        AppSettings.githubToken = client.token
    }
    
    func disconnect() {
        AppSettings.githubUrl = nil
        AppSettings.githubToken = nil
        connectionState = .unknown
        gitViewModel = nil
    }
    
    func clickQuitApp() {
        NSApplication.shared.terminate(nil)
    }
}
