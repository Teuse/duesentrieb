import SwiftUI

struct ConnectView: View {
    private let urlPreivew = "https://api.github.com/graphql"
    
    @EnvironmentObject private var rootViewModel: RootViewModel

    @State private var url = AppSettings.githubUrl?.absoluteString ?? ""
    @State private var token = AppSettings.githubToken ?? ""
    
    var canConnect: Bool { !url.isEmpty && !token.isEmpty }
    
    func connectAction() {
        rootViewModel.connectToGithub(gitUrl: url, token: token)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColor.darkBackground)
            
            VStack(spacing: 10) {
                
                Text("Wellcome to Düsentrieb")
                    .font(.largeTitle)
                    .foregroundColor(AppColor.primary)
                
                Spacer()
                
                HStack {
                    Text("Connect to github")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                
                TextField(urlPreivew, text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(AppColor.whiteTextColor)
                    .cornerRadius(5.0)
                
                SecureField("Github Developer Token", text: $token)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(AppColor.whiteTextColor)
                    .cornerRadius(5.0)
                
                if case let .error(errorMsg) = rootViewModel.connectionState {
                    errorText(text: errorMsg)
                }
                
                Spacer().frame(height: 5)
                LargeButton(text: "Connect", disabled: !canConnect, action: connectAction)
                
                Spacer().frame(height: 30)
                
                quitAppButton
            }
            .padding()
            .frame(maxWidth: 400)
            
            if case .connecting = rootViewModel.connectionState {
                loadingOverlay
            }
        }
    }
    
    var quitAppButton: some View {
        Button(action: rootViewModel.clickQuitApp) {
            Text("Quit App")
                .foregroundColor(AppColor.whiteTextColor)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
    
    var loadingOverlay: some View {
        ZStack {
            Rectangle()
                .fill(AppColor.darkBackground)
                .opacity(0.6)
            
            ActivityIndicator()
                .frame(width: 150, height: 150)
        }
    }
    
    func errorText(text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(Color.red)
            Spacer()
        }
    }
}
