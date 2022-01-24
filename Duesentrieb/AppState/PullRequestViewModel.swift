import Foundation
import Cocoa
import SwiftUI

class PullRequestViewModel: ObservableObject, Identifiable {
    let uuid = UUID()
    let user: User
    let pullRequest: PullRequest
    
    @Published private(set) var  reviewViewModels: [ReviewViewModel]
    
    var isMergeable: Bool? { pullRequest.mergeable == .mergeable }
    var mergeableDescription: String { pullRequest.mergeable.rawValue }
    var commentsCount: Int { pullRequest.commentsCount }
    var isApprovedOrDismissedByMe: Bool { isApproved(by: user) || isDismissed(by: user) }
    
    //MARK:- Life Circle
    
    init(pullRequest: PullRequest, user: User) {
        self.pullRequest = pullRequest
        self.user = user
        self.reviewViewModels = PullRequestViewModel.reviewStates(pullRequest: pullRequest)
    }

    //MARK:- Public Functions
    
    func openInBrowser() {
        guard let url = URL(string: pullRequest.url) else { return }
        NSWorkspace.shared.open(url)
    }
    
    func isApproved(by user: User) -> Bool {
        return pullRequest.reviews
            .contains(where: { user.isEqual(author: $0.author) && $0.state == .approved })
    }
    
    func isDismissed(by user: User) -> Bool {
        return pullRequest.reviews
            .contains(where: { user.isEqual(author: $0.author) && $0.state == .dismissed })
    }
    
    //MARK:- Private Functions
    
    static private func reviewStates(pullRequest: PullRequest) -> [ReviewViewModel] {
        let authors = uniqueReviewerAuthors(pullRequest: pullRequest)
        var states = [ReviewViewModel]()
        
        for author in authors {
            if pullRequest.requestedReviewer.contains(where: { $0.isEqual(author: author) }) {
                states.append(ReviewViewModel(state: .pending, author: author))
            } else if let review = pullRequest.reviews.filter({ $0.author.isEqual(author: author) }).sorted(by: { $0.createdAt < $1.createdAt }).last {
                states.append(ReviewViewModel(state: review.state, author: author))
            } else {
                assertionFailure()
//                states.append(ReviewViewModel(state: .pending, author: author))
            }
        }
        return states.sorted(by: { $0 < $1 })
    }
    
    static private func uniqueReviewerAuthors(pullRequest: PullRequest) -> [Author] {
        var authors = pullRequest.requestedReviewer.map{ Author(user: $0) }
        authors = authors + pullRequest.reviews
            .map{ $0.author }
        
        authors.removeDuplicates()
        return authors.filter{ !pullRequest.author.isEqual(author: $0)  }
    }
}
