import Foundation

struct PullRequest {
    let id: String
    let url: String
    let title: String
    let author: Author
    let commentsCount: Int
    let mergeable: MergeableState
    let reviewDecision: PullRequestReviewDecision?
    
    let requestedReviewer: [User]
    let reviews: [Review]
    
    //MARK:- Public Functions
    
    func isReviewRequest(for user: User) -> Bool {
        return !user.isEqual(author: author) &&
            (requestedReviewer.contains(where: { $0.isEqual(user: user) })
             || reviews.contains(where: { user.isEqual(author: $0.author) }))
    }
    
    func isPullRequest(from user: User) -> Bool {
        return user.isEqual(author: author)
    }
    
    //MARK:- GraphQL Types Initializer
    
    init?(pullRequest: RepositoriesQuery.Data.Viewer.Repository.Node.PullRequest.Node) {
        guard let author = pullRequest.author,
              let reviewRequests = pullRequest.reviewRequests?.nodes,
              let reviews = pullRequest.reviews?.nodes else {
                  print("ERROR: failed to create PullRequest object.")
                  return nil
              }
        self.author = Author(author: author)
        self.id = pullRequest.id
        self.url = pullRequest.url
        self.title = pullRequest.title
        self.commentsCount = pullRequest.comments.totalCount
        self.mergeable = pullRequest.mergeable
        self.reviewDecision = pullRequest.reviewDecision
        
        self.requestedReviewer = reviewRequests.compactMap{ User(requestedReviewer: $0?.requestedReviewer) }
//        guard let rrCount = pullRequest.reviewRequests?.totalCount, rrCount == self.requestedReviewer.count else {
//            print("ERROR: failed to create requestedReviewer object")
//            return nil
//        }
        
        self.reviews = reviews.compactMap{ Review(review: $0) }
        guard let reviewCount = pullRequest.reviews?.totalCount, reviewCount == self.reviews.count else {
            print("ERROR: failed to create reviews object")
            return nil
        }
    }
    
    init?(pullRequest: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node.PullRequest.Node) {
        guard let author = pullRequest.author,
              let reviewRequests = pullRequest.reviewRequests?.nodes,
              let reviews = pullRequest.reviews?.nodes else {
                  print("ERROR: failed to create PullRequest object.")
                  return nil
              }
        self.author = Author(author: author)
        self.id = pullRequest.id
        self.url = pullRequest.url
        self.title = pullRequest.title
        self.commentsCount = pullRequest.comments.totalCount
        self.mergeable = pullRequest.mergeable
        self.reviewDecision = pullRequest.reviewDecision
        
        self.requestedReviewer = reviewRequests.compactMap{ User(requestedReviewer: $0?.requestedReviewer) }
//        guard let rrCount = pullRequest.reviewRequests?.totalCount, rrCount == self.requestedReviewer.count else {
//            print("ERROR: failed to create requestedReviewer object")
//            return nil
//        }
        
        self.reviews = reviews.compactMap{ Review(review: $0) }
        guard let reviewCount = pullRequest.reviews?.totalCount, reviewCount == self.reviews.count else {
            print("ERROR: failed to create reviews object")
            return nil
        }
    }
}
