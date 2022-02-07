import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: 45)
    private let popover = NSPopover()
    
    private var rootState: RootState!
    private var menuBarIcon: MenuBarIcon?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {            
        rootState = RootState()
        let rootView = RootView()
            .environmentObject(rootState)
        
        popover.contentViewController = NSHostingController(rootView: rootView)
        popover.behavior = .transient
        
        if let button = statusBarItem.button {
            button.title = ""
            button.action = #selector(togglePopover(_:))
            menuBarIcon = MenuBarIcon(button: button, state: rootState)
        }
        
        // Run the 'reconnect' process after the initialization loop
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            self.rootState.reconnect()
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                rootState.triggerUpdate()
                
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                NSApplication.shared.activate(ignoringOtherApps: true)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
