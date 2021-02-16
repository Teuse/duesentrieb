import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: RootViewModel
    
    let closeAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            headline
                .padding([.leading, .trailing, .top])
            
            if let user = viewModel.gitViewModel?.user {
                ProfileSettingsView(user: user, disconnectAction: viewModel.clickDisconnect)
                    .padding([.leading, .trailing])
            }
            
            headline2
                .padding()
            
            if let model = viewModel.gitViewModel {
                ReposSettingsView(viewModel: model)
                    .padding([.leading, .trailing])
            } else {
                Text("Can't connect to github")
            }
        }
    }
    
    var headline: some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text("User Profile").font(.title)

                Spacer()
                
                Button(action: closeAction) {
                    Text("Ⅹ").font(.system(size: 25))
                }.buttonStyle(PlainButtonStyle())
            }
            .frame(height: 25)
            
            Rectangle().fill(Color.black)
                .frame(height: 1)
                .padding(.trailing, 50)
        }
    }
    
    var headline2: some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text("Manage Repositories").font(.title)
                Spacer()
            }
            .frame(height: 25)
            
            Rectangle().fill(Color.black)
                .frame(height: 1)
                .padding(.trailing, 50)
        }
    }
}
