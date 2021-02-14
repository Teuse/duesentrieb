import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    @State var settingsShown = false
    
    var body: some View {
        ZStack {
            if viewModel.needOnboarding {
                GithubSettingsView(applyText: "Apply")
                    .padding()
            }
            else if viewModel.requestState == .requesting {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
            }
            else if viewModel.requestState == .error {
                Text("Error")
            }
            else if settingsShown {
                SettingsView(viewModel: viewModel, shown: $settingsShown)
            }
            else if let vm = viewModel.gitViewModel {
                ReposView(viewModel: vm, settingsShown: $settingsShown)
            }
        }
        .frame(width: 400, height: 300)
    }
}
