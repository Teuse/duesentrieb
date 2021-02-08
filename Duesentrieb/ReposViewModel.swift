import Foundation

class ReposViewModel: ObservableObject {
    
    private let repos = [
        ("CCTouch", "i18n"),
        ("CarConfigurator", "scc-frontend"),
        ("CarConfigurator", "scc-service"),
    ]
    
    private var cancelBag = CancelBag()
    private let client: GithubClient
    private let user: User
    private var i18nController: RepoController
    private var b4fController: RepoController
    
    
    var myPRs: Int {
        return i18nController.pullRequests(ownedBy: user).count +
            b4fController.pullRequests(ownedBy: user).count
    }
    
    var openPRs: Int {
        return b4fController.pullRequests(toBeReviewedBy: user).count
    }
    
    var pullRequests: [PullRequest] {
        return i18nController.pullRequests + b4fController.pullRequests
    }
    
    init(client: GithubClient, user: User) {
        self.client = client
        self.user = user
        i18nController = RepoController(client: client, org: "CCTouch", repo: "i18n")
        b4fController = RepoController(client: client, org: "CarConfigurator", repo: "scc-frontend")
        
        i18nController.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
        
        b4fController.objectWillChange
            .sink(receiveValue: { self.objectWillChange.send() })
            .store(in: cancelBag)
    }
}
