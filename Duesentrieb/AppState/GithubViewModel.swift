import Foundation

class GithubViewModel: ObservableObject {
    private let client: GithubClient
    let user: User
    
    @Published private(set) var requestState = RequestState.unknown
    @Published private(set) var pullRequestViewModels = [PullRequestViewModel]()
    @Published private(set) var reviewRequestViewModels = [PullRequestViewModel]()
    
    //MARK:- Life Circle
    
    init(client: GithubClient, user: User, pullRequests: [PullRequest]) {
        self.client = client
        self.user = user
        updateViewModels(pullRequests: pullRequests)
        
        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.updatePullRequests()
        }
    }
    
    //MARK:- Private Functions
    
    func updatePullRequests() {
        client.fetchState(completion: { _, pullRequests in
            self.updateViewModels(pullRequests: pullRequests)
            self.requestState = .done
        }) { error in
            print("ERROR: failed to update PullRequests: \(error)")
            self.requestState = .error
        }
    }
    
    private func updateViewModels(pullRequests: [PullRequest]) {
        pullRequestViewModels = pullRequests
            .filter{ $0.author.login == user.login }
            .map{ PullRequestViewModel(pullRequest: $0) }
        
        reviewRequestViewModels = pullRequests
            .filter{ $0.author.login != user.login }
            .map{ PullRequestViewModel(pullRequest: $0) }
    }
}
