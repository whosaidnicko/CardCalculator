import Foundation

class TabbarViewModel: ObservableObject {
    static let shared = TabbarViewModel()
    
    private init() {}
    
    @Published var selectedTab: TabbarModel = .calc {
        didSet {
            if selectedTab == .timer {
                isVisible = false
            } else {
                isVisible = true
                previousSelectedTab = selectedTab
            }
        }
    }
    
    @Published var previousSelectedTab: TabbarModel = .calc
    @Published var isVisible: Bool = true
}
