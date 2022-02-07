import Foundation

class ReviewState: ObservableObject, Identifiable {
    let uuid = UUID()
    let state: PullRequestReviewState
    let author: Author
    
    init(state: PullRequestReviewState, author: Author) {
        self.state = state
        self.author = author
    }
}

extension ReviewState {
    static func < (lhs: ReviewState, rhs: ReviewState) -> Bool {
        return ReviewState.asNumber(state: lhs.state) < ReviewState.asNumber(state: rhs.state)
    }
    
    static func > (lhs: ReviewState, rhs: ReviewState) -> Bool {
        return ReviewState.asNumber(state: lhs.state) > ReviewState.asNumber(state: rhs.state)
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
