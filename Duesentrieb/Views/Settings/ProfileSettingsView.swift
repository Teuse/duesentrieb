import SwiftUI

struct ProfileSettingsView: View {
    let user: User
    let disconnectAction: () -> Void
    
    var body: some View {
        HStack {
            Image("UserProfileIcon")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.black)
            
            Spacer().frame(width: 20)
            VStack(alignment: .leading) {
                Text(user.login).bold()
                Text(user.email)
            }.padding()
            
            Spacer()
            disconnectButton
        }
    }
    
    var disconnectButton: some View  {
        Button(action: disconnectAction) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange, lineWidth: 3)
                
                Text("Disconnect")
                    .font(.title)
                    .foregroundColor(Color.orange)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 150, height: 30)
    }
}
