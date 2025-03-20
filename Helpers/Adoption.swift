import Foundation
import UIKit

extension Int {
    func adoption(_ scale: Double = 1.5) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 800 {
            return CGFloat(self) * (screenHeight / 844)
        } else {
            return CGFloat(self) * (screenHeight / 736)
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension UIDevice {
    static let isSmallIphone: Bool = UIScreen.main.bounds.height <= 680
}
