import Foundation

enum RequestState {
    case unknown, requesting, error, done
}

class RootViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    private let client: GithubClient?
    private var user: User?
    
    @Published private(set) var requestState = RequestState.unknown
    @Published private(set) var gitViewModel: GithubViewModel?
    
    var needOnboarding: Bool {
        return client == nil
    }
    
    var myPullRequestsCount: Int {
        guard let model = gitViewModel else { return 0 }
        return model.myPullRequests.count
    }
    
    var myReviewRequestsCount: Int {
        guard let model = gitViewModel else { return 0 }
        return model.myReviewRequests.count
    }
    
    init(client: GithubClient?) {
        self.client = client
        if let client = client {
            fetchUser(client: client)
        }
    }
    
    private func received(user: User, client: GithubClient) {
        self.user = user
        self.requestState = .done
        
        gitViewModel = GithubViewModel(client: client, user: user)
    }
    
    private func onFetchError(error: Error, client: GithubClient) {
        print("Couldn't fetch user. Error: \(error)")
        self.requestState = .error
        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in
            self.fetchUser(client: client)
        }
    }
    
    private func fetchUser(client: GithubClient) {
        requestState = .requesting
        client.loginUser()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
                if case let .failure(error) = completion {
                    self.onFetchError(error: error, client: client)
                }
            }, receiveValue: { user in
                self.received(user: user, client: client)
            })
            .store(in: cancelBag)
    }
}
