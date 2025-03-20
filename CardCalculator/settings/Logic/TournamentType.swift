import Foundation

enum TournamentType: String, CaseIterable {
    case fifteen = "15 min"
    case thirdty = "30 min"
    case fourtyFive = "45 min"
    
    func getMins() -> TimeInterval {
        switch self {
        case .fifteen:
            return 15 * 60
        case .thirdty:
            return 30 * 60
        case .fourtyFive:
            return 45 * 60
        }
    }
}
