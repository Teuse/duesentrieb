import Foundation

class GithubViewModel: ObservableObject {
    
    private let repos = [
        ("CarConfigurator", "scc-frontend"),
        ("CarConfigurator", "scc-service"),
        ("CarConfigurator", "viss"),
        ("dh-io-sccs", "postman"),
        ("dh-io-sccs", "sccs-wishlist"),
    ]
    
    @Published private(set) var pullsViewModel = [RepositoryViewModel]()
    
    private var cancelBag = CancelBag()
    private let client: GithubClient
    let user: User
    
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
        
        repos.forEach{ self.addRepo(org: $0.0, repo: $0.1) }
        triggerUpdate()
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.triggerUpdate()
        }
    }
    
    //MARK:- Private Functions
    
    private func triggerUpdate() {
        pullsViewModel.forEach{ $0.triggerUpdate() }
    }
    
    private func addRepo(org: String, repo: String) {
        let pulls = RepositoryViewModel(user: user, client: client, org: org, repo: repo)
        pullsViewModel.append(pulls)
        
        pulls.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
    }
}
