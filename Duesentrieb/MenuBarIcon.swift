import Foundation
import SwiftUI

class MenuBarIcon {
    let button: NSStatusBarButton
    let viewModel: RootViewModel
    
    private var animationCount = 0
    
    init(button: NSStatusBarButton, viewModel: RootViewModel) {
        self.button = button
        self.viewModel = viewModel
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateButton()
        }
    }
    
    private func updateButton() {
        let isCon = !viewModel.gitViewModels.isEmpty
        switch viewModel.connectionState {
        case .idle:         button.title = isCon ? createButtonTitle() : "Not Connected"
        case .connecting:   button.title = nextAnimationSymbol()
        case .error:        button.title = "⚠️"
        }
    }
    
    private func createButtonTitle() -> String {
        let numReviews = viewModel.numberOfOpenReviewRequests
        let numPullRequests = viewModel.numberOfOpenPullRequests
        let separator = viewModel.hasConnectionIssue ? "⚠️" : " | "
        
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
