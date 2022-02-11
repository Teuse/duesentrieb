import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var rootViewModel: RootState
    
    @Binding var page: AppPage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                headline("User Profile")
                addButton()
            }
            profileList()
            headline("About")
            Spacer().frame(height:5)
            info()
            Spacer()
        }
    }
    
    func addButton() -> some View {
        Button(action: { page = .connect }) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 35, height: 35)
        }
        .buttonStyle(PlainButtonStyle())
        .padding([.trailing, .top])
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
                .padding(.trailing)
        }
        .padding([.leading, .trailing, .top])
    }
    
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Version: \(rootViewModel.appVersion)")
            Text("© 2022 Mathi Radler, alle Rechte Vorbehalten.")
        }
        .padding([.leading, .trailing, .top])
    }
    
    func profileList() -> some View {
        ScrollView {
            ForEach(rootViewModel.gitStates, id: \.uuid) { gitState in
                ProfileSettingsView(user: gitState.user) {
                    rootViewModel.disconnect(service: gitState.service)
                }
                .padding([.leading, .trailing])
            }
        }
    }
}
