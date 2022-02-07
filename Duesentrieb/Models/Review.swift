import Foundation

struct Review {
    let state: PullRequestReviewState
    let author: Author
    let createdAt: Date

    //MARK:- GraphQL Types Initializer
    
    init?(review: RepositoriesQuery.Data.Viewer.Repository.Node.PullRequest.Node.Review.Node?) {
        guard let review = review, let author = review.author else { return nil }
        guard let createdAt = GithubClient.dateFormatter.date(from: review.createdAt) else {
            print("ERROR: failed to parse Date from String: \(review.createdAt)")
            return nil
        }
        
        self.state = review.state
        self.author = Author(reviewAuthor: author)
        self.createdAt = createdAt
    }
    
    init?(review: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node.PullRequest.Node.Review.Node?) {
        guard let review = review, let author = review.author else { return nil }
        guard let createdAt = GithubClient.dateFormatter.date(from: review.createdAt) else {
            print("ERROR: failed to parse Date from String: \(review.createdAt)")
            return nil
        }
        
        self.state = review.state
        self.author = Author(reviewAuthor: author)
        self.createdAt = createdAt
    }
}
