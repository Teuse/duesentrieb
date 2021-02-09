import SwiftUI

struct ReviewingRow: View {
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
                        Image("PullRequestIcon")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(pullRequest.title)
                            Text(pullRequest.user.login)
                                .font(.system(size: 10))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                    }
                }
                .frame(height: 35)
                .padding([.leading, .trailing])
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

//struct PullRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PullRow()
//    }
//}
