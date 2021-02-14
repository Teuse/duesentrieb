import Foundation

class GithubViewModel: ObservableObject {
    
    private var cancelBag = CancelBag()
    private let client: GithubClient
    let user: User
//        [
//        ("CarConfigurator", "scc-frontend"),
//        ("CarConfigurator", "scc-service"),
//        ("CarConfigurator", "viss"),
//        ("dh-io-sccs", "postman"),
//        ("dh-io-sccs", "sccs-wishlist"),
//    ]
    
    @Published private(set) var pullsViewModel = [RepositoryViewModel]()

    var myPullRequests: [PullRequest] {
        return pullsViewModel.flatMap { $0.pullRequests(ownedBy: user) }.map{ $0.pullRequest }
    }
    
    var myReviewRequests: [PullRequest] {
        return pullsViewModel.flatMap { $0.pullRequests(toBeReviewedBy: user) }.map{ $0.pullRequest }
    }
    
    var hasError: Bool {
        return pullsViewModel.contains(where: { $0.requestState == .error })
    }
    
    //MARK:- Life Circle
    
    init(client: GithubClient, user: User) {
        self.client = client
        self.user = user
        
        AppSettings.repoPaths.forEach{ self.addRepo(repoPath: $0) }
        triggerUpdate()
        
        AppNotifications.addRepositoryPublisher()
            .sink(receiveValue: { self.addRepo(repoPath: $0) })
            .store(in: cancelBag)
        
        AppNotifications.deleteRepositoryPublisher()
            .sink(receiveValue: { self.deleteRepo(repoPath: $0) })
            .store(in: cancelBag)
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.triggerUpdate()
        }
    }
    
    //MARK:- Private Functions
    
    func triggerUpdate() {
        pullsViewModel.forEach{ $0.triggerUpdate() }
    }
    
    private func addRepo(repoPath: RepositoryPath) {
        let pulls = RepositoryViewModel(user: user, client: client,
                                        repoPath: repoPath)
        pullsViewModel.append(pulls)
        
        pulls.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
    }
    
    private func deleteRepo(repoPath: RepositoryPath) {
        pullsViewModel.removeAll(where: { $0.repoPath.uuid == repoPath.uuid })
    }
}
