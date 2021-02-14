import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published private(set) var pullRequests = [PullRequestViewModel]()
    @Published private(set) var requestState = RequestState.unknown
    
    let uuid = UUID()
    let repoPath: RepositoryPath
    let user: User
    
    private let client: GithubClient
    private var cancelBag = CancelBag()
    
    init(user: User, client: GithubClient, repoPath: RepositoryPath) {
        self.user = user
        self.client = client
        self.repoPath = repoPath
    }
    
    func triggerUpdate() {
        guard requestState != .requesting else { return }
        fetchPRs()
    }
    
    func pullRequests(ownedBy user: User) -> [PullRequestViewModel] {
        return pullRequests.filter({ $0.type == .mine })
    }
    
    func pullRequests(toBeReviewedBy user: User) -> [PullRequestViewModel] {
        return pullRequests.filter({ $0.type == .reviewing || $0.type == .didReview })
    }
    
    //MARK:- Private Functions
    
    private func didFetchDetails(_ details: [(PullRequest, [Review])]) {
        self.pullRequests.removeAll()
        details.forEach{
            let vm = PullRequestViewModel(pullRequest: $0.0, reviews: $0.1, user: self.user)
            self.pullRequests.append(vm)
        }
    }
    
    private func fetchPRs() {
        
//        let user = User(id: 1, login: "blub")
//        let repos = Repository(id: 1, name: "", owner: user)
//        let commit = Commit(sha: "", user: user, repo: repos)
//
//        var details = [(PullRequest, [Review])]()
//        for i in 1...4 {
//            let rewiever = User(id: 2646, login: "MARODER")
//            let pr = PullRequest(id: i, url: "", title: "", user: user, number: 1, state: "", head: commit, mergeable: false, mergeableState: "BLUB", requestedReviewers: [rewiever])
//
//            details.append((pr, []))
//        }
//
//        didFetchDetails(details)
//        return
        
        requestState = .requesting

        client.listOpenPRs(org: repoPath.org, repo: repoPath.repo)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: failed to fetch PRs (\(self.repoPath.pathString)): \(error.localizedDescription)")
                    self.requestState = .error
                }
            }, receiveValue: { pulls in
                self.fetchDetails(pulls)
            })
            .store(in: cancelBag)
    }
    
    private func fetchDetails(_ pulls: [PullEntry]) {
        Publishers.Sequence(sequence: pulls)
            .flatMap{ self.client.pullRequestDetails(org: self.repoPath.org, repo: self.repoPath.repo, prNumber: $0.number) }
            .collect()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: failed to fetch PRs (\(self.repoPath.pathString)): \(error.localizedDescription)")
                    self.requestState = .error
                }
            }, receiveValue: { result in
                self.didFetchDetails(result)
                self.requestState = .done
            })
            .store(in: cancelBag)
    }
}
