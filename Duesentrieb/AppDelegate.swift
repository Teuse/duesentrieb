import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: 45)
    private let popover = NSPopover()
    
    private var rootViewModel: RootViewModel!
    private var menuBarIcon: MenuBarIcon?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {            
        rootViewModel = RootViewModel()
        let rootView = RootView(viewModel: rootViewModel)
        
        popover.contentViewController = NSHostingController(rootView: rootView)
        popover.behavior = .transient
        
        if let button = statusBarItem.button {
            button.title = ""
            button.action = #selector(togglePopover(_:))
            menuBarIcon = MenuBarIcon(button: button, viewModel: rootViewModel)
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                rootViewModel.gitViewModel?.updateViewModel()
                
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                NSApplication.shared.activate(ignoringOtherApps: true)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
