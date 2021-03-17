import SwiftUI

struct PullRequestRow: View {
    @ObservedObject var viewModel: PullRequestViewModel

    private func action() {
        viewModel.openInBrowser()
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.1)
                
                VStack(spacing: 0) {
                    HStack {
                        Image(viewModel.type == .mine ? "BranchIcon" : "PullRequestIcon")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(viewModel.pullRequest.title)
                            ZStack {
                                HStack {
                                    Text(viewModel.pullRequest.user.login)
                                        .font(.system(size: 10))
                                        .foregroundColor(Color.gray)
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
                        MergableIndication(mergeable: viewModel.isMergeable,
                                           description: viewModel.mergeableDescription)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: 45)
        .opacity(viewModel.type == .didReview ? 0.3 : 1)
    }
    
    var reviewsIndicators: some View {
        HStack {
            ForEach(viewModel.approvedReviews, id: \.id) { review in
                ApprovedIndication(userName: review.user.login, state: review.state)
            }
            ForEach(viewModel.pullRequest.requestedReviewers, id: \.id) { reviewer in
                ApprovedIndication(userName: reviewer.login, state: .unknown)
            }
        }
    }
    
    var commentsIndicator: some View {
        HStack(spacing: 2) {
            Text("\(viewModel.comments.count)")
            Text("💬")
        }
    }
}

