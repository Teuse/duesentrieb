import SwiftUI

struct RepositoryView: View {
    @ObservedObject var viewModel: RepositoryViewModel
    let page: Int
    
    var isEmpty: Bool {
        page == 0 ? viewModel.reviewRequestViewModels.isEmpty : viewModel.pullRequestViewModels.isEmpty
    }
    
    var body: some View {
        if !isEmpty {
            section(viewModel: viewModel)
                .frame(height: 18)
            
            if self.page == 0 {
                pullRequests(prViewModels: viewModel.reviewRequestViewModels)
            } else {
                pullRequests(prViewModels: viewModel.pullRequestViewModels)
            }
        }
    }
    
    private func section(viewModel: RepositoryViewModel) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            
            HStack {
                Text("\(viewModel.name)")
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    private func pullRequests(prViewModels: [PullRequestViewModel]) -> some View {
        ForEach(prViewModels, id: \.uuid) { pullRequest in
            PullRequestRow(viewModel: pullRequest)
            
            //Separator
            if pullRequest.uuid != prViewModels.last?.uuid {
                Rectangle().fill(Color.black).frame(height: 1)
            }
        }
    }
}
