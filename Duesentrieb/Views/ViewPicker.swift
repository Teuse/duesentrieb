import SwiftUI

struct ViewPicker: View {
    
    @Binding var selection: Int
    var colors = ["Reviewing", "Mine"]
    
    var body: some View {
        
        HStack(spacing: 0) {
            Button(action: { self.selection = 0 }) {
                pickerButton(text: "Reviewing", selected: selection == 0)
            }.buttonStyle(PlainButtonStyle())
            Rectangle()
                .fill(Color.black)
                .frame(width: 1)
            
            Button(action: { self.selection = 1 }) {
                pickerButton(text: "Mine", selected: selection == 1)
            }.buttonStyle(PlainButtonStyle())
        }
        .frame(height: 25)
        .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.black, lineWidth: 1))
        .padding()
        
    }
    
    func pickerButton(text: String, selected: Bool) -> some View {
        ZStack {
            Rectangle()
                .fill(selected ? Color.orange : Color.gray)
            
            HStack {
                Spacer()
                Text(text)
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
    
}


//struct ViewPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewPicker()
//    }
//}
