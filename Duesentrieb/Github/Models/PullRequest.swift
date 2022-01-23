import Foundation

struct PullRequest {
    let id: String
    let url: String
    let title: String
    let repositoryName: Repository
    let author: Author
    let createdAt: String
    let number: Int
    let state: PullRequestState
    let commentsCount: Int
    let mergeable: MergeableState
    let reviewDecision: PullRequestReviewDecision?
    
    let requestedReviewer: [User]
    let reviews: [Review]
    
    init?(pullRequest: StateQuery.Data.Viewer.PullRequest.Node?) {
        guard let pullRequest = pullRequest,
              let baseRepo = pullRequest.baseRepository,
              let author = pullRequest.author,
              let reviewRequests = pullRequest.reviewRequests?.nodes,
              let reviews = pullRequest.reviews?.nodes else {
            print("ERROR: failed to create PullRequest object.")
            return nil
        }
        self.repositoryName = Repository(repo: baseRepo)
        self.author = Author(author: author)
        
        self.id = pullRequest.id
        self.url = pullRequest.url
        self.title = pullRequest.title
        self.createdAt = pullRequest.createdAt
        self.number = pullRequest.number
        self.state = pullRequest.state
        self.commentsCount = pullRequest.comments.totalCount
        self.mergeable = pullRequest.mergeable
        self.reviewDecision = pullRequest.reviewDecision
        
        self.requestedReviewer = reviewRequests.compactMap{ User(requestedReviewer: $0?.requestedReviewer) }
        guard let rrCount = pullRequest.reviewRequests?.totalCount, rrCount == self.requestedReviewer.count else {
            print("ERROR: failed to create requestedReviewer object")
            return nil
        }
        
        self.reviews = reviews.compactMap{ Review(review: $0) }
        guard let reviewCount = pullRequest.reviews?.totalCount, reviewCount == self.reviews.count else {
            print("ERROR: failed to create reviews object")
            return nil
        }
    }
}
