import SwiftUI

struct GithubSettingsView: View {
    @State private var gitUrl = AppSettings.githubUrl
    @State private var gitToken = AppSettings.githubToken
    
    let applyText: String
    
    func applyAction() {
        if !gitUrl.isEmpty {
            AppSettings.githubUrl = gitUrl
        }
        if !gitToken.isEmpty {
            AppSettings.githubToken = gitToken
        }
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.reloadApp()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Github URL: ")
                Spacer()
                TextField("https://api.github.com/api/v3", text: $gitUrl)
                    .frame(width: 270)
            }
            
            HStack {
                Text("Github Token: ")
                Spacer()
                SecureField("developer token from github", text: $gitToken)
                    .frame(width: 270)
            }
            Spacer().frame(height: 5)
            LargeButton(text: applyText, action: applyAction)
        }
    }
}

struct GithubSettings_Previews: PreviewProvider {
    static var previews: some View {
        GithubSettingsView(applyText: "blub")
    }
}
