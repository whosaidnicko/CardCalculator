import Foundation

enum TableType: String, CaseIterable {
    case cash = "Cash game"
    case tournament = "Tournament"
    case sitGo = "Sit & Go"
    case headsUp = "Heads-Up"
    case freeroll = "Freeroll"
    
    static func from(rawValue: String) -> TableType? {
        return TableType.allCases.first { $0.rawValue == rawValue }
    }
}
