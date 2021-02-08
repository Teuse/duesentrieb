import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            
            if viewModel.requestState == .requesting {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
            } else if viewModel.requestState == .error {
                Text("Error")
            } else {
                
                VStack {
                    ViewPicker()
                    
                    //            List(viewModel.pullRequests, id: \.id) { pullRequest in
                    //                Text("[\(pullRequest.head.repo.name)] \(pullRequest.title)")
                    //            }
                    
                }
                .frame(width: 400, height: 300)
            }
        }
    }
}


//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView(viewModel: GithubController())
//    }
//}
