import Foundation
import Cocoa

enum PullRequestType {
    case mine
    case reviewing
    case didReview
    case unknown
}

class PullRequestViewModel: ObservableObject, Identifiable {
    let uuid = UUID()
    let user: User
    
    @Published var pullRequest: PullRequest
    @Published var reviews: [Review]
    
    var approvedReviews: [Review] {
        let approved = reviews.filter{ $0.approved }
        return removeDuplicateUsers(from: approved)
    }
    
    var isMergeable: Bool? {
        let state = pullRequest.mergeableState
        guard let mergeable = pullRequest.mergeable, state != .unknown else {
            return nil
        }
        return mergeable && (state == .clean || state == .hasHooks)
    }
    
    var mergeableDescription: String {
        guard let mergeable = isMergeable else {
            return "Mergeable State Unknown"
        }
        let state = pullRequest.mergeableState
        return mergeable ? "Mergeable" : "Not Mergeable: \(state.rawValue)"
    }
    
    var type: PullRequestType {
        if pullRequest.user.id == user.id     { return .mine }
        if pullRequest.isReviewer(user: user) { return .reviewing }
        if isApproved(by: user)               { return .didReview }
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
 
    private func isApproved(by user: User) -> Bool {
        return reviews.contains(where: { $0.user.id == user.id && $0.approved })
    }
    
    private func removeDuplicateUsers(from reviews: [Review]) -> [Review] {
        var filtered = [Review]()
        for rev in reviews {
            if !filtered.contains(where: { $0.user.id == rev.user.id }) {
                filtered.append(rev)
            }
        }
        return filtered
    }
}
