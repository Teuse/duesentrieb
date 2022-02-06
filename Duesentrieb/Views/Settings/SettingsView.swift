import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: RootViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            headline("User Profile")
                
            if let user = viewModel.gitViewModel?.user {
                ProfileSettingsView(user: user, disconnectAction: viewModel.disconnect)
                    .padding([.leading, .trailing])
            }
            headline("About")
            Spacer().frame(height:5)
            info()
            Spacer()
        }
    }
    
    func headline(_ title: String) -> some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text(title).font(.title)
                Spacer()
            }
            .frame(height: 25)
            
            Rectangle().fill(Color.black)
                .frame(height: 1)
                .padding(.trailing, 50)
        }
        .padding([.leading, .trailing, .top])
    }
    
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Version: \(viewModel.versionNumber).\(viewModel.buildNumber)")
            Text("© 2022 Mathi Radler, alle Rechte Vorbehalten.")
        }
        .padding([.leading, .trailing, .top])
    }
}
