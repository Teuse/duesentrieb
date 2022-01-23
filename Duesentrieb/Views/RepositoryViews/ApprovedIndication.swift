import SwiftUI

struct ApprovedIndication: View {
    @State private var showPopover: Bool = false
    
    let author: String
    let state: PullRequestReviewState
    
    var body: some View {
        approvedIcon
            .onHover { over in
                showPopover = over
            }
            .popover(isPresented: self.$showPopover, arrowEdge: .bottom) {
                popoverContent
            }
    }
    
    var approvedIcon: some View {
        ZStack {
            if state == .approved {
                Text("✓").font(.system(size: 15)).foregroundColor(.green)
            } else if state == .changesRequested {
                Text("±").font(.system(size: 17)).foregroundColor(.red).offset(y: -1)
            } else if state == .dismissed {
                Text("🔴").font(.system(size: 6))
            } else {
                Text("🟡").font(.system(size: 6))
            }
        }
    }
    
    var popoverContent: some View {
        ZStack {
            Text(author)
        }
        .frame(width: 100, height: 20)
    }
}

//struct ReviewedIndication_Previews: PreviewProvider {
//    static var previews: some View {
//        ApprovedIndication(userName: "ABCDEFG", approved: false)
//    }
//}
