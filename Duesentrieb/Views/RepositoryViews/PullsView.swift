import SwiftUI

struct PullsView: View {
    @ObservedObject var viewModel: GithubViewModel
    let pullRequests: [PullRequestViewModel]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    //                    ForEach(viewModel.reposViewModel) { repo in
                    //
                    //                        if !pullRequests(for: repo).isEmpty {
                    //                            section(repo: repo)
                    //                                .frame(height: 18)
                    
                    
                    ForEach(pullRequests, id: \.uuid) { pr in
                        PullRequestRow(viewModel: pr)
                        
                        //Separator
//                        if pr.pullRequest.id != pullRequests().last?.pullRequest.id {
//                            Rectangle().fill(Color.black).frame(height: 1)
//                        }
                    }
                    //                        }
                    //                    }
                    
                    Spacer()
                    Rectangle() // Fix a bug in ScrollView
                        .frame(width: geometry.size.width, height: 0.01)
                }
            }
        }
    }
    
    //    private func section(repo: RepositoryViewModel) -> some View {
    //        ZStack {
    //            Rectangle()
    //                .fill(Color.gray)
    //
    //            HStack {
    //                Text("\(repo.repoPath.pathString)")
    //                    .bold()
    //                    .padding(.leading)
    //                    .foregroundColor(.white)
    //                Spacer()
    //            }
    //        }
    //    }
}

//struct PullsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PullsView()
//    }
//}
