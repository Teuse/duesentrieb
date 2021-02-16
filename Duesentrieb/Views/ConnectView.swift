import SwiftUI

struct ConnectView: View {
    private let urlPreivew = "https://api.github.com/api/v3"
    
    @ObservedObject var viewModel: RootViewModel
    
    @State private var url = AppSettings.githubUrl
    @State private var token = AppSettings.githubToken
    
    var canConnect: Bool { !url.isEmpty && !token.isEmpty }
    
    func connectAction() {
        guard canConnect else { return }
        viewModel.clickConnect(gitUrl: url, token: token)
    }
    
    func quitAppAction() {
        viewModel.clickQuitApp()
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
                
                if viewModel.connectionState == .error {
                    errorText
                }
                
                Spacer().frame(height: 5)
                LargeButton(text: "Connect", disabled: !canConnect, action: connectAction)
                
                Spacer().frame(height: 30)
                
                quitAppButton
            }
            .padding()
            .frame(maxWidth: 400)
            
            if viewModel.connectionState == .requesting {
                loadingOverlay
            }
        }
    }
    
    var quitAppButton: some View {
        Button(action: quitAppAction) {
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
    
    var errorText: some View {
        HStack {
            Text("Connection failed. Please check the url and token and try again...")
                .foregroundColor(Color.red)
            Spacer()
        }
    }
}

//struct ConnectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectView()
//    }
//}
