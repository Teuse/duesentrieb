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
                                    reviewsIndicators
                                    Spacer().frame(width: 15)
                                    commentsIndicator
                                    Spacer()
                                }
                                .offset(x: 70)
                            }
                        }
                        Spacer()
                        Text(viewModel.pullRequest.mergeable ? "✓" : "✗")
                            .font(.headline)
                            .bold()
                            .foregroundColor(viewModel.pullRequest.mergeable ? Color.green : Color.red)
                    }
                }
                .padding([.leading, .trailing])
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(height: 45)
    }
    
    var reviewsIndicators: some View {
        HStack {
            ForEach(viewModel.reviews.filter({$0.approved}), id: \.id) { review in
                ApprovedIndication(userName: review.user.login, approved: true)
            }
            ForEach(viewModel.pullRequest.requestedReviewers, id: \.id) { reviewer in
                ApprovedIndication(userName: reviewer.login, approved: false)
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

