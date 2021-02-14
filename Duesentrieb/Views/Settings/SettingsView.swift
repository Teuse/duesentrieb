import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: RootViewModel
    
    @Binding var shown: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            headline
                .padding()
            
            GithubSettingsView(applyText: "Apply and restart App")
                .padding([.leading, .trailing, .bottom])
            
            if let model = viewModel.gitViewModel {
                ReposSettingsView(viewModel: model)
            } else {
                Text("Can't connect to github")
            }
        }
    }
    
    var headline: some View {
        VStack(spacing: 5) {
            HStack(spacing: 0) {
                Text("Settings").font(.title)
                
                Spacer()
                
                LargeButton(text: "Quit App") {
                    NSApplication.shared.terminate(nil)
                }.frame(width: 100)
                
                Spacer()
                
                Button(action: { shown.toggle() }) {
                    Text("Ⅹ").font(.system(size: 25))
                }.buttonStyle(PlainButtonStyle())
            }
            .frame(height: 25)
            
            Rectangle().fill(Color.black)
                .frame(height: 1)
                .padding(.trailing, 50)
        }
    }
}
