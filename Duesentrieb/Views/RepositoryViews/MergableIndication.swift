import SwiftUI

struct MergableIndication: View {
    @State private var showPopover: Bool = false
    
    let mergeable: Bool?
    let description: String
    
    var symbol: String {
        guard let mergeable = mergeable else {
            return "?"
        }
        return mergeable ? "✓" : "✗"
    }
    
    var symbolColor: Color {
        guard let mergeable = mergeable else {
            return Color.black
        }
        return mergeable ? Color.green : Color.red
    }
    
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
        Text(symbol)
            .font(.headline)
            .bold()
            .foregroundColor(symbolColor)
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
