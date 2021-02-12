import Foundation

enum RequestState {
    case unknown, requesting, error, done
}

class RootViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    private let client: GithubClient
    private var user: User?
    
    @Published private(set) var requestState = RequestState.unknown
    @Published private(set) var reposViewModel: GithubViewModel?
    
    var myPullRequestsCount: Int {
        guard let model = reposViewModel else { return 0 }
        return model.myPullRequests.count
    }
    
    var myReviewRequestsCount: Int {
        guard let model = reposViewModel else { return 0 }
        return model.myReviewRequests.count
    }
    
    init(client: GithubClient) {
        self.client = client
        fetchUser()
    }
    
    private func received(user: User) {
        self.user = user
        self.requestState = .done
        
        reposViewModel = GithubViewModel(client: client, user: user)
        
        reposViewModel?.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
    }
    
    private func onFetchError(error: Error) {
        print("Couldn't fetch user. Error: \(error)")
        self.requestState = .error
        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in
            self.fetchUser()
        }
    }
    
    private func fetchUser() {
        requestState = .requesting
        client.loginUser()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
                if case let .failure(error) = completion {
                    self.onFetchError(error: error)
                }
            }, receiveValue: { user in
                self.received(user: user)
            })
            .store(in: cancelBag)
    }
}
