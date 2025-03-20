

import SwiftUI

enum TabbarModel: String, Hashable, CaseIterable {
    case timer = "Timer"
    case calc = "Calc"
    case diary = "Diary"
    case settings = "Settings"
    
    func iconSource() -> ImageResource {
        switch self {
        case .timer:
            ImageResource.clockIcon
        case .calc:
            ImageResource.calculatorIcon
        case .diary:
            ImageResource.bookIcon
        case .settings:
            ImageResource.settingsIcon
        }
    }
}
