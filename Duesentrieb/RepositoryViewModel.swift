import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    
    @Published private(set) var pullRequests = [PullRequestViewModel]()
    @Published private(set) var requestState = RequestState.unknown
    
    let uuid = UUID()
    let org: String
    let repo: String
    let user: User
    
    private let client: GithubClient
    private var cancelBag = CancelBag()
    
    init(user: User, client: GithubClient, org: String, repo: String) {
        self.user = user
        self.client = client
        self.org = org
        self.repo = repo
    }
    
    func triggerUpdate() {
        guard requestState != .requesting else { return }
        fetchPRs()
    }
    
    func pullRequests(ownedBy user: User) -> [PullRequest] {
        return pullRequests.filter({ $0.type == .mine }).map{ $0.pullRequest }
    }
    
    func pullRequests(toBeReviewedBy user: User) -> [PullRequest] {
        return pullRequests.filter({ $0.type == .reviewing }).map{ $0.pullRequest }
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
        requestState = .requesting
        
        client.listOpenPRs(org: org, repo: repo)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: failed to fetch PRs (\(self.org)/\(self.repo)): \(error.localizedDescription)")
                    self.requestState = .error
                }
            }, receiveValue: { pulls in
                self.fetchDetails(pulls)
            })
            .store(in: cancelBag)
    }
    
    private func fetchDetails(_ pulls: [PullEntry]) {
        Publishers.Sequence(sequence: pulls)
            .flatMap{ self.client.pullRequestDetails(org: self.org, repo: self.repo, prNumber: $0.number) }
            .collect()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: failed to fetch PRs (\(self.org)/\(self.repo)): \(error.localizedDescription)")
                    self.requestState = .error
                }
            }, receiveValue: { result in
                self.didFetchDetails(result)
                self.requestState = .done
            })
            .store(in: cancelBag)
    }
}
