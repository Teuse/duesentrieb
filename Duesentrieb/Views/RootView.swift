import SwiftUI

enum AppPage: Int {
    case main, settings, connect
}

struct RootView: View {
    @EnvironmentObject private var rootState: RootState
    
    @State var currentPage = AppPage.main
    
    var body: some View {
        ZStack {
            if rootState.gitStates.isEmpty || currentPage == .connect {
                ConnectView() {
                    currentPage = .settings
                }
            }
            else {
                mainViews
            }
        }
        .frame(width: 600, height: 400)
    }
    
    var mainViews: some View {
        HStack(spacing: 0) {
            SideBar(page: $currentPage) {
                rootState.clickQuitApp()
            }
            
            if currentPage == .settings {
                SettingsView(page: $currentPage)
            }
            else if !rootState.gitStates.isEmpty, currentPage == .main {
                MainView()
            }
            else {
                Text("What happend here?")
            }
        }
    }
}
