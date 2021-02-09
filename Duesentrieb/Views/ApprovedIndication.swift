import SwiftUI

struct ApprovedIndication: View {
    @State private var showPopover: Bool = false
    
    let userName: String
    let approved: Bool
    
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
            if approved {
                Text("✓").font(.system(size: 15)).foregroundColor(.green)
            } else {
                Text("🟡").font(.system(size: 6))
            }
        }
    }
    
    var popoverContent: some View {
        ZStack {
            Text(userName)
        }
        .frame(width: 100, height: 20)
    }
}

struct ReviewedIndication_Previews: PreviewProvider {
    static var previews: some View {
        ApprovedIndication(userName: "ABCDEFG", approved: false)
    }
}
