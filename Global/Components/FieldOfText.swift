import SwiftUI

struct FieldOfText: View {
    
    @Binding var text: String
    let placeholder: String
    
    var isValid: Bool = true
    var isSecured: Bool = false
    
    var hasDollar: Bool = false
    
    var body: some View {
        HStack(spacing: 8.adoption()) {
            if hasDollar {
                Text("$")
                    .font(Font.custom("Aldrich", size: 16.adoption()))
                    .foregroundColor(Color(red: 0.47, green: 0.95, blue: 0.5))
            }
            
            if isSecured {
                SecureField(placeholder, text: $text)
                    .font(.aldrich(16.adoption()))
            } else {
                TextField(placeholder, text: $text)
                    .font(.aldrich(16.adoption()))
            }
        }
        .padding(.horizontal, 12.adoption())
        .frame(height: 50.adoption())
        .background(.white.opacity(0.1))
        .cornerRadius(8.adoption())
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.5)
                .stroke(isValid ? Color(red: 0.29, green: 0.33, blue: 0.39) : Color.red, lineWidth: 1)
        )
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .tint(.white)
    }
}

#Preview {
    FieldOfText(text: .constant(""), placeholder: "Enter amount")
    FieldOfText(text: .constant("123456"), placeholder: "Enter amount")
    FieldOfText(text: .constant("123456"), placeholder: "Enter amount", isValid: false)
    FieldOfText(text: .constant("123456"), placeholder: "Enter amount", hasDollar: true)
}
