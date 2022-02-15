import Foundation

class RepositoryState: ObservableObject, Identifiable {
    let uuid = UUID()
    let user: User
    let repository: Repository
    
    @Published private(set) var pullRequestStates: [PullRequestState]
    @Published private(set) var reviewRequestStates: [PullRequestState]
    
    var name: String { repository.nameWithOwner }
    
    var numberOfOpenPullRequests: Int {
        return pullRequestStates.count
    }

    var numberOfOpenReviewRequests: Int {
        return reviewRequestStates.filter{ !$0.isApproved }.count
    }
    
    //MARK:- Life Circle
    
    init(repo: Repository, user: User) {
        self.user = user
        self.repository = repo
        
        pullRequestStates = repo.pullRequests(from: user)
            .map{ PullRequestState(pullRequest: $0, user: user) }
        
        reviewRequestStates = repo.reviewRequests(for: user)
            .map{ PullRequestState(pullRequest: $0, user: user) }
    }
}
