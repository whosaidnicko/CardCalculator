import SwiftUI

struct LoaderView: View {
    @State private var isLoadingRectangle: Bool = false
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.applicationLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 220.adoption(), height: 175.adoption())
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 3.adoption())
                .foregroundColor(.clear)
                .frame(width: 304.adoption(), height: 17.adoption())
                .background(LinearGradient.grayGradient)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3.adoption())
                        .foregroundStyle(LinearGradient.greenGradient)
                        .frame(width: isLoadingRectangle ? 304.adoption() : 0) // Animate width
                        .animation(.linear(duration: 3), value: isLoadingRectangle)
                }
                .padding(.bottom, 5.adoption())
        }
        .onAppear {
            isLoadingRectangle = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            }
        }
    }
}

#Preview {
    LoaderView(isLoading: .constant(false))
}
