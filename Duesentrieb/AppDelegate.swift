import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private static let baseUrl = "https://git.daimler.com/api/v3"
    private static let token = ""
    
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: 55)
    private let popover = NSPopover()
    
    private let client = GithubClient(session: URLSession.shared, baseUrl: baseUrl, token: token)
    private var rootViewModel: RootViewModel!
    
    private var animationCount = 0
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        rootViewModel = RootViewModel(client: client)
        let contentView = RootView(viewModel: rootViewModel)
        
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        statusBarItem.button?.title = ""
        statusBarItem.button?.action = #selector(togglePopover(_:))

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateButton()
        }
    }
    
    private var separator: String {
        if let rvm = rootViewModel.reposViewModel, rvm.hasError {
            return "⚠️"
        }
        return "|"
    }
    
    private func updateButton() {
        if rootViewModel.requestState == .requesting {
            statusBarItem.button?.title = nextAnimationSymbol()
        } else if rootViewModel.requestState == .error {
            statusBarItem.button?.title = "⚠️"
        } else if rootViewModel.requestState == .done {
            statusBarItem.button?.title =
                "\(rootViewModel.myReviewRequestsCount)  \(separator)  \(rootViewModel.myPullRequestsCount)"
        } else {
            statusBarItem.button?.title = "?"
        }
    }
    
    private func nextAnimationSymbol() -> String {
        animationCount += 1
        switch animationCount {
        case 1: return "▪️"
        case 2: animationCount = 0; return "  "
        default: return "?"
        }
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                rootViewModel.reposViewModel?.triggerUpdate()
                
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                NSApplication.shared.activate(ignoringOtherApps: true)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
