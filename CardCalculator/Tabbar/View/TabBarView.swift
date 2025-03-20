import SwiftUI

struct TabbarView: View {
    @Binding var selectedTab: TabbarModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabbarModel.allCases, id: \.self) { tabItem in
                Button(action: { withAnimation(.default) { selectedTab = tabItem } },
                       label: {
                    VStack(spacing: 8.adoption()) {
                        Image(tabItem.iconSource())
                            .resizable()
                            .renderingMode(selectedTab.rawValue == tabItem.rawValue ? .template : .original)
                            .foregroundStyle(LinearGradient.greenGradient)
                            .scaledToFit()
                            .frame(width: 18.adoption(), height: 18.adoption())
                            .clipped()
                        
                        Text("\(tabItem.rawValue)")
                            .font(Font.custom("Aldrich", size: 12.adoption()))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(selectedTab.rawValue == tabItem.rawValue ? Color(hex: 0x77F37F) : Color.appGray)
                    }
                })
                .frame(maxWidth: .infinity)
            }
        }
        .padding([.top, .horizontal], 16.adoption())
        .padding(.bottom, UIDevice.isSmallIphone ? 24.adoption() : 12.adoption())
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.24, green: 0.24, blue: 0.24), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.19, green: 0.18, blue: 0.2), location: 0.50),
                    Gradient.Stop(color: Color(red: 0.18, green: 0.18, blue: 0.19), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
        )
        .overlay(alignment: .top) {
            Rectangle()
                .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.32))
                .frame(height: 1)
        }
    }
}

#Preview {
    VStack(spacing: 50) {
        TabbarView(selectedTab: .constant(.calc))
        TabbarView(selectedTab: .constant(.diary))
    }
}
