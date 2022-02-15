import SwiftUI

struct ConnectView: View {
    private static let urlPreivew = "https://api.github.com/graphql"
    
    @EnvironmentObject private var rootState: RootState
    
    @State private var url = ConnectView.urlPreivew
    @State private var token = ""
    
    let backAction: () -> Void
    
    var canConnect: Bool { !url.isEmpty && !token.isEmpty }
    
    func connectAction() {
        rootState.connectToGithub(gitUrl: url, token: token) {
            if !rootState.gitStates.isEmpty, case .idle = rootState.connectionState {
                backAction()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColor.darkBackground)
            
            VStack(spacing: 10) {
                
                ZStack {
                    Text("Wellcome to Düsentrieb")
                        .font(.largeTitle)
                        .foregroundColor(AppColor.primary)
                    if !rootState.gitStates.isEmpty {
                        HStack(spacing: 0) {
                            backArrow
                            Spacer()
                        }
                    }
                }
                Spacer()
                
                HStack {
                    Text("Connect to github")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                
                TextField(ConnectView.urlPreivew, text: $url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(AppColor.whiteTextColor)
                    .cornerRadius(5.0)
                
                SecureField("Github Developer Token", text: $token)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(AppColor.whiteTextColor)
                    .cornerRadius(5.0)
                
                if case let .error(errorMsg) = rootState.connectionState {
                    errorText(text: errorMsg)
                }
                
                Spacer().frame(height: 5)
                LargeButton(text: "Connect", disabled: !canConnect, action: connectAction)
                
                Spacer().frame(height: 30)
                
                quitAppButton
            }
            .padding()
            .frame(maxWidth: 500)
            
            if case .connecting = rootState.connectionState {
                loadingOverlay
            }
        }
    }
    
    var quitAppButton: some View {
        Button(action: rootState.clickQuitApp) {
            Text("Quit App")
                .foregroundColor(AppColor.whiteTextColor)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
    
    var backArrow: some View {
        Button(action: backAction) {
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(AppColor.whiteTextColor)
        }
        .buttonStyle(PlainButtonStyle())
        .padding([.top], 5)
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
