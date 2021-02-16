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
    
    @Published private(set) var requestState = RequestState.unknown
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
        
        AppSettings.repoPaths = reposViewModel.map{ $0.repoPath }
    }
    
    func deleteRepo(repoPath: RepositoryPath) {
        reposViewModel.removeAll(where: { $0.repoPath.uuid == repoPath.uuid })
        
        AppSettings.repoPaths = reposViewModel.map{ $0.repoPath }
    }
    
    func checkRepo(repoPath: RepositoryPath, callback: @escaping (Bool) -> Void) {
        requestState = .requesting

        client.listOpenPRs(org: repoPath.org, repo: repoPath.repo)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: failed to fetch PRs (\(repoPath.pathString)): \(error.localizedDescription)")
                    self.requestState = .error
                    callback(false)
                }
            }, receiveValue: { _ in
                self.requestState = .done
                callback(true)
            })
            .store(in: cancelBag)
    }
}
