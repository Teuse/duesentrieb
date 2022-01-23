import Foundation
import Cocoa
import SwiftUI

class PullRequestViewModel: ObservableObject, Identifiable {
    let uuid = UUID()
    @Published var pullRequest: PullRequest
    
    init(pullRequest: PullRequest) {
        self.pullRequest = pullRequest
    }
   
    var isMergeable: Bool? { pullRequest.mergeable == .mergeable }
    
    var mergeableDescription: String { pullRequest.mergeable.rawValue }

    var commentsCount: Int { pullRequest.commentsCount }

    func openInBrowser() {
        guard let url = URL(string: pullRequest.url) else { return }
        NSWorkspace.shared.open(url)
    }
//    
//    //MARK:- Private Functions
// 
//    private func isApproved(by user: User) -> Bool {
//        return reviews.contains(where: { $0.user.id == user.id && $0.state == .approved })
//    }
//    
//    private func removeDuplicateUsers(from reviews: [Review]) -> [Review] {
//        var filtered = [Review]()
//        for rev in reviews {
//            if !filtered.contains(where: { $0.user.id == rev.user.id }) {
//                filtered.append(rev)
//            }
//        }
//        return filtered
//    }
}
