import SwiftUI

struct PullsView: View {
    @ObservedObject var viewModel: GithubViewModel
    let page: Int
    
    func pullRequests(for repo: RepositoryViewModel) -> [PullRequest] {
        switch page {
        case 0: return repo.pullRequests(toBeReviewedBy: viewModel.user)
        case 1: return repo.pullRequests(ownedBy: viewModel.user)
        default: assertionFailure()
        }
        return []
    }
    
    var body: some View {

        ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.pullsViewModel, id: \.uuid) { repo in
                        if !pullRequests(for: repo).isEmpty {
                            section(text: "\(repo.org)/\(repo.repo)")
                            
                            ForEach(pullRequests(for: repo), id: \.id) { pr in
                                VStack(spacing: 0) {
                                    if page == 0 {
                                        ReviewingRow(pullRequest: pr) { viewModel.openInBrowser(pullRequest: pr) }
                                    } else {
                                        MineRow(pullRequest: pr) { viewModel.openInBrowser(pullRequest: pr) }
                                    }
                                    
                                    if pr.id != repo.pullRequests.last?.pullRequest.id {
                                        Rectangle().fill(Color.black).frame(height: 1)
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
    private func section(text: String) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            
            HStack {
                Text(text)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
}

//struct PullsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PullsView()
//    }
//}
