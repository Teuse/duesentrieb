import SwiftUI

struct ReposView: View {
    @ObservedObject var viewModel: GithubViewModel
    
    @State var page: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ViewPicker(selection: $page)
                    .padding(.trailing)
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
