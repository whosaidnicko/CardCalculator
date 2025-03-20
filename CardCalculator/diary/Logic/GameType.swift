import Foundation

enum GameType: String, CaseIterable {
    case texas = "Texas Hold'em"
    case omana = "Omaha"
    case sevenCard = "Seven Card Stud"
    case pineapple = "Pineapple"
    case razz = "Razz"
    
    static func from(rawValue: String) -> GameType? {
        return GameType.allCases.first { $0.rawValue == rawValue }
    }
}
