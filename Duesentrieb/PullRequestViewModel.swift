import Foundation

enum PullRequestType {
    case mine
    case reviewing
    case unknown
}

class PullRequestViewModel: ObservableObject {
    let uuid = UUID()
    let pullRequest: PullRequest
    let reviews: [Review]
    let user: User

    var type: PullRequestType {
        if pullRequest.user.id == user.id     { return .mine }
        if pullRequest.isReviewer(user: user) { return .reviewing }
        return .unknown
    }
    
    init(pullRequest: PullRequest, reviews: [Review], user: User) {
        self.pullRequest = pullRequest
        self.reviews = reviews
        self.user = user
    }

    
    //MARK:- Private Functions
    
}
