import SwiftUI

enum AppPage: Int {
    case main, settings
}

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    @State var currentPage = AppPage.main
    
    var body: some View {
        ZStack {
            if viewModel.connectionState == .done {
                mainViews
            }
            else {
                ConnectView(viewModel: viewModel)
            }
        }
        .frame(width: 500, height: 400)
    }
    
    var mainViews: some View {
        HStack(spacing: 0) {
            SideBar(page: $currentPage) {
                viewModel.clickQuitApp()
            }
            
            if currentPage == .settings {
                SettingsView(viewModel: viewModel) {
                    currentPage = .main
                }
            }
            else if let vm = viewModel.gitViewModel, currentPage == .main {
                MainView(viewModel: vm)
            }
            else {
                Text("What happend here?")
            }
        }
    }
}
