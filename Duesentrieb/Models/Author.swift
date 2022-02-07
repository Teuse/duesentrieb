import Foundation

struct Author: Hashable {
    let login: String
    let avatarUrl: String
    
    func isEqual(author: Author) -> Bool {
        self.login == author.login
    }
    
    init(user: User) {
        self.login = user.login
        self.avatarUrl = user.avatarUrl
    }
    
    //MARK:- GraphQL Types Initializer
    
    init(author: RepositoriesQuery.Data.Viewer.Repository.Node.PullRequest.Node.Author) {
        self.login = author.login
        self.avatarUrl = author.avatarUrl
    }
    
    init(reviewAuthor: RepositoriesQuery.Data.Viewer.Repository.Node.PullRequest.Node.Review.Node.Author) {
        self.login = reviewAuthor.login
        self.avatarUrl = reviewAuthor.avatarUrl
    }
    
    init(author: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node.PullRequest.Node.Author) {
        self.login = author.login
        self.avatarUrl = author.avatarUrl
    }
    
    init(reviewAuthor: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node.PullRequest.Node.Review.Node.Author) {
        self.login = reviewAuthor.login
        self.avatarUrl = reviewAuthor.avatarUrl
    }
}
