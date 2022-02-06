import Foundation

class RepositoryViewModel: ObservableObject, Identifiable {
    let uuid = UUID()
    let user: User
    let repository: Repository
    
    @Published private(set) var pullRequestViewModels: [PullRequestViewModel]
    @Published private(set) var reviewRequestViewModels: [PullRequestViewModel]
    
    var name: String { repository.nameWithOwner }
    
    var numberOfOpenPullRequests: Int {
        return pullRequestViewModels.count
    }

    var numberOfOpenReviewRequests: Int {
        return reviewRequestViewModels.filter{ !$0.isApproved }.count
    }
    
    //MARK:- Life Circle
    
    init(repo: Repository, user: User) {
        self.user = user
        self.repository = repo
        
        pullRequestViewModels = repo.pullRequests(from: user)
            .map{ PullRequestViewModel(pullRequest: $0, user: user) }
        
        reviewRequestViewModels = repo.reviewRequests(for: user)
            .map{ PullRequestViewModel(pullRequest: $0, user: user) }
    }
}
