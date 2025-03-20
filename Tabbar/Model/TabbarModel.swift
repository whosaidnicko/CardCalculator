

import SwiftUI

enum TabbarModel: String, Hashable, CaseIterable {
    case home = "Home"
    case schedule = "Schedule"
    case timer = "Timer"
    case profile = "Profile"
    
    func iconSource() -> ImageResource {
        switch self {
        case .home:
            ImageResource.homeIcon
        case .schedule:
            ImageResource.calendarIcon
        case .timer:
            ImageResource.clockIcon
        case .profile:
            ImageResource.profileIcon
        }
    }
}
