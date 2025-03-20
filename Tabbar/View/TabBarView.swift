import SwiftUI

struct TabbarView: View {
    @Binding var selectedTab: TabbarModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabbarModel.allCases, id: \.self) { tabItem in
                Button(action: { withAnimation(.default) { selectedTab = tabItem } },
                       label: {
                    VStack(spacing: 8.flexible()) {
                        Image(tabItem.iconSource())
                            .resizable()
                            .renderingMode(selectedTab.rawValue == tabItem.rawValue ? .original : .template)
                            .foregroundStyle(Color.appGray)
                            .scaledToFit()
                            .frame(width: 18.flexible(), height: 18.flexible())
                            .clipped()
                        
                        Text("\(tabItem.rawValue)")
                            .font(Font.inter(12.flexible()))
                            .foregroundColor(selectedTab.rawValue == tabItem.rawValue ? Color.appYellow: Color.appGray)
                    }
                })
                .frame(maxWidth: .infinity)
            }
        }
        .padding([.top, .horizontal], 24.flexible())
        .padding(.bottom, UIDevice.isSmallIphone ? 24.flexible() : 12.flexible())
        .frame(maxWidth: .infinity)
        .background(Color.darkBlue)
        .overlay(alignment: .top) {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color(red: 0.22, green: 0.25, blue: 0.32))
        }
    }
}

#Preview {
    VStack(spacing: 50) {
        TabbarView(selectedTab: .constant(.profile))
        TabbarView(selectedTab: .constant(.home))
    }
}
