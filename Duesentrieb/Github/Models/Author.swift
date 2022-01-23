import Foundation

struct Author {
    let login: String
    let avatarUrl: String
    
    init(author: StateQuery.Data.Viewer.PullRequest.Node.Author) {
        self.login = author.login
        self.avatarUrl = author.avatarUrl
    }
    
    init(reviewAuthor: StateQuery.Data.Viewer.PullRequest.Node.Review.Node.Author) {
        self.login = reviewAuthor.login
        self.avatarUrl = reviewAuthor.avatarUrl
    }
}
