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
        switch viewModel.connectionState {
        case .unknown:      button.title = "Connect"
        case .requesting:   button.title = nextAnimationSymbol()
        case .error:        button.title = "⚠️"
        case .done:         button.title = createButtonTitle()
        }
    }
    
    private func createButtonTitle() -> String {
//        guard let rvm = viewModel.gitViewModel else { return "" }
//
//        let separator = rvm.hasError ? "⚠️" : " | "
//        return "\(viewModel.myReviewRequestsCount) \(separator) \(viewModel.myPullRequestsCount)"
        return "! | !"
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
