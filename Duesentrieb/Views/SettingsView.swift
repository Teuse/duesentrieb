import SwiftUI

struct SettingsView: View {
    
    @Binding var shown: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                Button(action: { shown.toggle() }) {
                    Text("Ⅹ").font(.system(size: 20))
                }.buttonStyle(PlainButtonStyle())
            }
            .padding()
            
            Spacer()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(shown: .constant(true))
    }
}
