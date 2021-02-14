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
    
    @Published private(set) var reposViewModel = [RepositoryViewModel]()

    var myPullRequests: [PullRequest] {
        return reposViewModel.flatMap { $0.pullRequests(ownedBy: user) }.map{ $0.pullRequest }
    }
    
    var myReviewRequests: [PullRequest] {
        return reposViewModel.flatMap { $0.pullRequests(toBeReviewedBy: user) }.map{ $0.pullRequest }
    }
    
    var hasError: Bool {
        return reposViewModel.contains(where: { $0.requestState == .error })
    }
    
    //MARK:- Life Circle
    
    init(client: GithubClient, user: User) {
        self.client = client
        self.user = user
        
        AppSettings.repoPaths.forEach{ self.addRepo(repoPath: $0) }
        triggerUpdate()
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.triggerUpdate()
        }
    }
    
    //MARK:- Private Functions
    
    func triggerUpdate() {
        reposViewModel.forEach{ $0.triggerUpdate() }
    }
    
    func addRepo(repoPath: RepositoryPath) {
        let pulls = RepositoryViewModel(user: user, client: client,
                                        repoPath: repoPath)
        reposViewModel.append(pulls)
        
        pulls.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
    }
    
    func deleteRepo(repoPath: RepositoryPath) {
        reposViewModel.removeAll(where: { $0.repoPath.uuid == repoPath.uuid })
    }
}
