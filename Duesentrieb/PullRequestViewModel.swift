import Foundation
import Cocoa

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
    
    var comments: [Review] { reviews.filter({ $0.isComment })}
    
    init(pullRequest: PullRequest, reviews: [Review], user: User) {
        self.pullRequest = pullRequest
        self.reviews = reviews
        self.user = user
    }

    func openInBrowser() {
        guard let url = URL(string: pullRequest.url) else { return }
        NSWorkspace.shared.open(url)
    }
    
    //MARK:- Private Functions
    
}
