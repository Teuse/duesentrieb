import Foundation

class ReviewViewModel: ObservableObject, Identifiable {
    let uuid = UUID()
    let state: PullRequestReviewState
    let author: Author
    
    init(state: PullRequestReviewState, author: Author) {
        self.state = state
        self.author = author
    }
}

extension ReviewViewModel {
    static func < (lhs: ReviewViewModel, rhs: ReviewViewModel) -> Bool {
        return ReviewViewModel.asNumber(state: lhs.state) < ReviewViewModel.asNumber(state: rhs.state)
    }
    
    static func > (lhs: ReviewViewModel, rhs: ReviewViewModel) -> Bool {
        return ReviewViewModel.asNumber(state: lhs.state) > ReviewViewModel.asNumber(state: rhs.state)
    }
        
    private static func asNumber(state: PullRequestReviewState) -> Int {
        switch state {
        case .approved: return 1
        case .dismissed: return 2
        case .changesRequested: return 3
        case .commented: return 4
        case .pending: return 5
        default: return 6
        }
    }
}
