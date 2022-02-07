import Foundation
import SwiftUI

class MenuBarIcon {
    let button: NSStatusBarButton
    let state: RootState
    
    private var animationCount = 0
    
    init(button: NSStatusBarButton, state: RootState) {
        self.button = button
        self.state = state
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateButton()
        }
    }
    
    private func updateButton() {
        let isCon = !state.gitStates.isEmpty
        switch state.connectionState {
        case .idle:         button.title = isCon ? createButtonTitle() : "Not Connected"
        case .connecting:   button.title = nextAnimationSymbol()
        case .error:        button.title = "⚠️"
        }
    }
    
    private func createButtonTitle() -> String {
        let numReviews = state.numberOfOpenReviewRequests
        let numPullRequests = state.numberOfOpenPullRequests
        let separator = state.hasConnectionIssue ? "⚠️" : " | "
        
        return "\(numReviews) \(separator) \(numPullRequests)"
    }
    
    private func nextAnimationSymbol() -> String {
        animationCount += 1
        switch animationCount {
        case 1: return "▪️"
        case 2: animationCount = 0; return "  "
        default: return "?"
        }
    }
}
