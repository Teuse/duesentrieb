import SwiftUI

struct PullRequestRow: View {
    @ObservedObject var state: PullRequestState

    private func action() {
        state.openInBrowser()
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.1)
                
                VStack(spacing: 0) {
                    HStack {
//                        Image(state.type == .pullRequest ? "BranchIcon" : "PullRequestIcon")
                        Image("PullRequestIcon")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(state.pullRequest.title)
                            ZStack {
                                HStack {
                                    Text(state.pullRequest.author.login)
                                        .font(.system(size: 10))
                                        .foregroundColor(AppColor.grayTextColor)
                                    Spacer()
                                }
                                HStack {
                                    commentsIndicator
                                    Spacer().frame(width: 40)
                                    reviewsIndicators
                                    Spacer()
                                }
                                .offset(x: 70)
                            }
                        }
                        Spacer()
                        MergableIndication(mergeable: state.isMergeable,
                                           description: state.mergeableDescription)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: 45)
        .opacity(state.isResolved ? 0.5 : 1)
    }
    
    var reviewsIndicators: some View {
        HStack {
            ForEach(state.reviewStates, id: \.uuid) {
                ReviewStateIndicator(state: $0)
            }
        }
    }
    
    var commentsIndicator: some View {
        HStack(spacing: 2) {
            Text("\(state.commentsCount)")
            Text("💬")
        }
    }
}

