import SwiftUI

struct MineRow: View {
    let pullRequest: PullRequest
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.1)
                
                VStack(spacing: 0) {
                    HStack {
                        Image("BranchIcon")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                        Text(pullRequest.title)
                        Spacer()
                        Text(pullRequest.mergeable ? "✓" : "✗")
                            .font(.headline)
                            .bold()
                            .foregroundColor(pullRequest.mergeable ? Color.green : Color.red)
                    }
                }
                .frame(height: 35)
                .padding([.leading, .trailing])
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

