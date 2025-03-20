import SwiftUI

struct SecondaryButtonView: View {
    let title: String
    let icon: ImageResource?
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        }, label: {
            HStack(spacing: 12.adoption()) {
                if let icon {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.adoption(), height: 16.adoption())
                }
                
                Text(title)
                    .font(Font.custom("Aldrich", size: 16.adoption()))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .offset(y: 1.adoption())
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 42.adoption())
            .frame(height: 56.adoption())
            .background(.white.opacity(0.2))
            .cornerRadius(12.adoption())
        })
    }
}

#Preview {
    SecondaryButtonView(title: "Setup", icon: .toolsIcon) {}
}
