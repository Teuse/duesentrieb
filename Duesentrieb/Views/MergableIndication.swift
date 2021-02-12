import SwiftUI

struct MergableIndication: View {
    @State private var showPopover: Bool = false
    
    let mergeable: Bool
    let description: String
    
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
        Text(mergeable ? "✓" : "✗")
            .font(.headline)
            .bold()
            .foregroundColor(mergeable ? Color.green : Color.red)
    }
    
    var popoverContent: some View {
        ZStack {
            Text(description)
        }
        .frame(width: 100, height: 20)
    }
}

//struct MergableIndication_Previews: PreviewProvider {
//    static var previews: some View {
//        MergableIndication()
//    }
//}
