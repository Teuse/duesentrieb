import Foundation

struct User {
    let id: String
    let login: String
    let name: String?
    let email: String
    let avatarUrl: String
    
    func isEqual(user: User) -> Bool {
        return self.login.caseInsensitiveCompare(user.login) == .orderedSame
    }
    
    func isEqual(author: Author) -> Bool {
        return self.login.caseInsensitiveCompare(author.login) == .orderedSame
    }
    
    //MARK:- GraphQL Types Initializer
    
    init(qlViewer: UserQuery.Data.Viewer) {
        self.id = qlViewer.id
        self.login = qlViewer.login
        self.name = qlViewer.name
        self.email = qlViewer.email
        self.avatarUrl = qlViewer.avatarUrl
    }

    init?(requestedReviewer: RepositoriesQuery.Data.Viewer.Repository.Node.PullRequest.Node.ReviewRequest.Node.RequestedReviewer?) {
        guard let requestedReviewer = requestedReviewer?.asUser else { return nil }
        self.id = requestedReviewer.id
        self.login = requestedReviewer.login
        self.name = requestedReviewer.name
        self.email = requestedReviewer.email
        self.avatarUrl = requestedReviewer.avatarUrl
    }
    
    init?(requestedReviewer: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node.PullRequest.Node.ReviewRequest.Node.RequestedReviewer?) {
        guard let requestedReviewer = requestedReviewer?.asUser else { return nil }
        self.id = requestedReviewer.id
        self.login = requestedReviewer.login
        self.name = requestedReviewer.name
        self.email = requestedReviewer.email
        self.avatarUrl = requestedReviewer.avatarUrl
    }
}
