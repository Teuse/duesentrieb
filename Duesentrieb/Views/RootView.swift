import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack {
            if viewModel.requestState == .requesting {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
            } else if viewModel.requestState == .error {
                Text("Error")
            } else if let vm = viewModel.reposViewModel {
                ReposView(viewModel: vm)
            }
        }.frame(width: 400, height: 300)
    }
}
