import Foundation

class RepoController: ObservableObject {
    
    @Published private(set) var pullRequests = [PullRequest]()
    
    private let client: GithubClient
    private let org: String
    private let repo: String
    
    private var cancelBag = CancelBag()
    private var requestCount = 0
    
    init(client: GithubClient, org: String, repo: String) {
        self.client = client
        self.org = org
        self.repo = repo
    }
    
    func triggerUpdate() {
        guard requestCount == 0 else { return }
        
        fetchPRs()
    }
    
    func pullRequests(ownedBy user: User) -> [PullRequest] {
        return pullRequests.filter({ $0.user.id == user.id })
    }
    
    func pullRequests(toBeReviewedBy user: User) -> [PullRequest] {
        return pullRequests.filter({ $0.isReviewer(user: user) })
    }
    
    //MARK:- Private Functions
    
    private func fetchPRs() {
        requestCount += 1
        client.listOpenPRs(org: org, repo: repo)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                self.requestCount -= 1
                if case let .failure(error) = completion {
                    print("Couldn't fetch open PRs. Error: \(error)")
                }
            }, receiveValue: { pulls in
                self.pullRequests = pulls
            })
            .store(in: cancelBag)
    }
}
