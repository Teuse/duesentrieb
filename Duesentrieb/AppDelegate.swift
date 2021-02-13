import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: 55)
    private let popover = NSPopover()
    
    private var rootViewModel: RootViewModel!
    private var animationCount = 0
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem.button?.title = ""
        statusBarItem.button?.action = #selector(togglePopover(_:))

        popover.behavior = .transient
        reloadApp()
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.updateButton()
        }
    }
    
    func reloadApp() {
        let rootView = createRootView()
        popover.contentViewController = NSHostingController(rootView: rootView)
    }
    
    private func createRootView() -> RootView {
        let url = AppSettings.githubUrl
        let token = AppSettings.githubToken
        let client = !url.isEmpty && !token.isEmpty
            ? GithubClient(session: URLSession.shared, baseUrl: url, token: token)
            : nil
        
        rootViewModel = RootViewModel(client: client)
        return RootView(viewModel: rootViewModel)
    }
    
    private var separator: String {
        if let rvm = rootViewModel.reposViewModel, rvm.hasError {
            return "⚠️"
        }
        return " | "
    }
    
    private func updateButton() {
        if rootViewModel.needOnboarding {
            statusBarItem.button?.title = "Setup!"
        } else if rootViewModel.requestState == .requesting {
            statusBarItem.button?.title = nextAnimationSymbol()
        } else if rootViewModel.requestState == .error {
            statusBarItem.button?.title = "⚠️"
        } else if rootViewModel.requestState == .done {
            statusBarItem.button?.title =
                "\(rootViewModel.myReviewRequestsCount) \(separator) \(rootViewModel.myPullRequestsCount)"
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
