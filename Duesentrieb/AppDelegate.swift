import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: 45)
    private let popover = NSPopover()
    
    private var rootViewModel: RootViewModel!
    private var menuBarIcon: MenuBarIcon?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {            
        rootViewModel = RootViewModel()
        let rootView = RootView()
            .environmentObject(rootViewModel)
        
        popover.contentViewController = NSHostingController(rootView: rootView)
        popover.behavior = .transient
        
        if let button = statusBarItem.button {
            button.title = ""
            button.action = #selector(togglePopover(_:))
            menuBarIcon = MenuBarIcon(button: button, viewModel: rootViewModel)
        }
        
        // Run the 'reconnect' process after the initialization loop
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.rootViewModel.reconnect()
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                rootViewModel.triggerUpdate()
                
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                NSApplication.shared.activate(ignoringOtherApps: true)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
