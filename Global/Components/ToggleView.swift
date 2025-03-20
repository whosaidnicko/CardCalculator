import SwiftUI

struct ToggleView: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Capsule()
            .frame(width: 44.adoption(), height: 24.adoption())
            .foregroundStyle(isOn ? Color.appGreen : Color(hex: 0x9CA3AF))
            .overlay(alignment: isOn ? .trailing : .leading) {
                Circle()
                    .foregroundStyle(Color.white)
                    .padding(3.adoption())
            }
            .onTapGesture {
                withAnimation(.default) { isOn.toggle() }
            }
    }
}

#Preview {
    ToggleView(isOn: .constant(false))
    ToggleView(isOn: .constant(true))
}
