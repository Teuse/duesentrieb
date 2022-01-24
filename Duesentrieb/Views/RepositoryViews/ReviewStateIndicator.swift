import SwiftUI

struct ReviewStateIndicator: View {
    @ObservedObject var viewModel: ReviewViewModel
    
    @State private var showPopover: Bool = false
    
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
            if viewModel.state == .approved {
                Text("✓").font(.system(size: 15)).foregroundColor(.green)
            } else if viewModel.state == .changesRequested {
                Text("±").font(.system(size: 17)).foregroundColor(.red).offset(y: -1)
            } else if viewModel.state == .dismissed {
                Text("🔴").font(.system(size: 6))
            } else if viewModel.state == .commented {
                Text("💬").font(.system(size: 6))
            } else {
                Text("🟡").font(.system(size: 6))
            }
        }
    }
    
    var popoverContent: some View {
        ZStack {
            Text(viewModel.author.login)
        }
        .frame(width: 100, height: 20)
    }
}

//struct ReviewedIndication_Previews: PreviewProvider {
//    static var previews: some View {
//        ApprovedIndication(userName: "ABCDEFG", approved: false)
//    }
//}
