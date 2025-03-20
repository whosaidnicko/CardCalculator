
import SwiftUI

extension Color {
    
    static let appGray = Color(hex: 0x9CA3AF)
    static let darkGray = Color(hex: 0x343336)
    static let backgroundColor = Color(hex: 0x1C1C1C)
    static let appGreen =  Color(hex: 0x77F37F)
    static let appBlack =  Color(hex: 0x374151)
    
    init(hex: UInt64) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

extension LinearGradient {
    static let greenGradient = LinearGradient(
        colors: [
            Color(hex: 0x419253),
            Color(hex: 0x77F37F)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    
    static let redGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.95, green: 0.47, blue: 0.47), location: 0.00),
            Gradient.Stop(color: Color(red: 0.57, green: 0.25, blue: 0.25), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.96, y: 0),
        endPoint: UnitPoint(x: 0.06, y: 0.95)
    )
    
    
    static let grayGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.24, green: 0.24, blue: 0.24), location: 0.00),
            Gradient.Stop(color: Color(red: 0.19, green: 0.18, blue: 0.2), location: 0.50),
            Gradient.Stop(color: Color(red: 0.18, green: 0.18, blue: 0.19), location: 1.00),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
}
