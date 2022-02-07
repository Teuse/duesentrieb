import SwiftUI

enum AppPage: Int {
    case main, settings, connect
}

struct RootView: View {
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    @State var currentPage = AppPage.main
    
    var body: some View {
        ZStack {
            if rootViewModel.gitViewModels.isEmpty || currentPage == .connect {
                ConnectView()
            }
            else {
                mainViews
            }
        }
        .frame(width: 500, height: 400)
    }
    
    var mainViews: some View {
        HStack(spacing: 0) {
            SideBar(page: $currentPage) {
                rootViewModel.clickQuitApp()
            }
            
            if currentPage == .settings {
                SettingsView(page: $currentPage)
            }
            else if let vm = rootViewModel.gitViewModels.first, currentPage == .main {
                MainView(viewModel: vm)
            }
            else {
                Text("What happend here?")
            }
        }
    }
}
