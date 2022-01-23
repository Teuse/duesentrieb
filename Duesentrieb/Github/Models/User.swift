import Foundation

struct User {
    let id: String
    let login: String
    let email: String
    let avatarUrl: String
    
    init(viewer: StateQuery.Data.Viewer) {
        self.id = viewer.id
        self.login = viewer.login
        self.email = viewer.email
        self.avatarUrl = viewer.avatarUrl
    }
    
    init?(requestedReviewer: StateQuery.Data.Viewer.PullRequest.Node.ReviewRequest.Node.RequestedReviewer?) {
        guard let requestedReviewer = requestedReviewer?.asUser else { return nil }
        self.id = requestedReviewer.id
        self.login = requestedReviewer.login
        self.email = requestedReviewer.email
        self.avatarUrl = requestedReviewer.avatarUrl
    }
}
