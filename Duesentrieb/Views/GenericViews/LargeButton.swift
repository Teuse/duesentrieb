import SwiftUI

struct LargeButton: View {
    let text: String
    let disabled: Bool
    let action: () -> Void
    
    init(text: String, action: @escaping ()->Void) {
        self.text = text
        self.disabled = false
        self.action = action
    }
    
    init(text: String, disabled: Bool, action: @escaping ()->Void) {
        self.text = text
        self.disabled = disabled
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Button(action: action) {
                HStack(spacing: 0) {
                    Spacer()
                    VStack(spacing: 0) {
                        Spacer()
                        Text(text)
//                            .font(.headline)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    Spacer()
                }
                
            }.buttonStyle(PlainButtonStyle())
        }
        .frame(height: 25)
        .background(disabled ? AppColor.primaryDark : AppColor.primary)
        .cornerRadius(3.0)
        .disabled(disabled)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        LargeButton(text: "Login", action: {})
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
