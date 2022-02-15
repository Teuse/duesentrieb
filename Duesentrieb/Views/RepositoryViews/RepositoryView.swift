import SwiftUI

struct RepositoryView: View {
    @ObservedObject var repoState: RepositoryState
    let page: Int
    
    var isEmpty: Bool {
        page == 0 ? repoState.reviewRequestStates.isEmpty : repoState.pullRequestStates.isEmpty
    }
    
    var body: some View {
        if !isEmpty {
            section(state: repoState)
                .frame(height: 18)
            
            if self.page == 0 {
                pullRequests(prStates: repoState.reviewRequestStates)
            } else {
                pullRequests(prStates: repoState.pullRequestStates)
            }
        }
    }
    
    private func section(state: RepositoryState) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
            
            HStack {
                Text("\(state.name)")
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    private func pullRequests(prStates: [PullRequestState]) -> some View {
        ForEach(prStates, id: \.uuid) { pullRequest in
            PullRequestRow(state: pullRequest)
            
            //Separator
            if pullRequest.uuid != prStates.last?.uuid {
                Rectangle().fill(Color.black).frame(height: 1)
            }
        }
    }
}
