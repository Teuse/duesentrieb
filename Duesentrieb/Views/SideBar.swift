import SwiftUI

struct SideBar: View {
    @Binding var page: AppPage
    
    let quitAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(AppColor.darkBackground)
            
            VStack(spacing: 10) {
                mainPageButton
                
                Spacer()
                
                Button(action: { page = .settings }) {
                    Text("⚙︎")
                        .font(.system(size: 35))
                        .foregroundColor(page == .settings ? AppColor.primary : AppColor.whiteTextColor)
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: quitAction) {
                    Text("⎋")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                }.buttonStyle(PlainButtonStyle())
                Spacer().frame(height: 5)
            }
            .frame(width: 40)
        }
        .frame(width: 40)
    }
    
    var mainPageButton: some View {
            Button(action: { page = .main }) {
                ZStack {
                    Rectangle()
                        .fill(AppColor.darkBackground)
                        .frame(width: 40, height: 150)
                    
                    Text("DÜSENTRIEB")
                        .font(.system(size: 20)).bold()
                        .frame(width: 400)
                        .rotationEffect(.degrees(270))
                        .foregroundColor(page == .main ? AppColor.primary : AppColor.whiteTextColor)
                }
            }
            .buttonStyle(PlainButtonStyle())
    }
}
