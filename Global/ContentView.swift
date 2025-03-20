import SwiftUI

struct ContentView: View {
    
    @ObservedObject var tabbarVM = TabbarViewModel.shared
    
    
    var body: some View {
      
        ZStack {
            NavigationStack {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        switch tabbarVM.selectedTab {
                        case .timer:
                            TimerView()
                        case .calc:
                            CalcView()
                        case .diary:
                            DiaryView()
                        case .settings:
                            SettingsView()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.backgroundColor)
                    
                    if tabbarVM.isVisible {
                        TabbarView(selectedTab: $tabbarVM.selectedTab)
                    }
                }
            }
        }
        .ribkamechti()
        .onAppear() { print("porgna")}
        
    }
}

#Preview {
    ContentView()
}
