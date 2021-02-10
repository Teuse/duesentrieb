import SwiftUI

struct ReposView: View {
    @ObservedObject var viewModel: GithubViewModel
    @Binding var settingsShown: Bool
    
    @State var page: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ViewPicker(selection: $page)
                    .padding(.trailing)
                
                Button(action: { settingsShown.toggle() }) {
                    Text("⚙").font(.system(size: 36)).offset(y: -2)
                }.buttonStyle(PlainButtonStyle())
            }
            .padding()
            
            PullsView(viewModel: viewModel, page: page)
            
            Spacer()       
        }
    }
}

//struct ReposView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReposView()
//    }
//}
