import Foundation

struct Review {
    let uuid = UUID()
    let state: PullRequestReviewState
    let author: Author
    
    init?(review: StateQuery.Data.Viewer.PullRequest.Node.Review.Node?) {
        guard let review = review, let author = review.author else { return nil }
        self.state = review.state
        self.author = Author(reviewAuthor: author)
    }
}
