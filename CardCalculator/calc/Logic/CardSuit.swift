import Foundation

struct Card: Hashable {
    let suit: CardSuit
    let value: CardValue
    
    func getImageName() -> String {
        return "\(value.rawValue)\(suit.rawValue)"
    }
}

enum CardSuit: String, CaseIterable {
    case spades = "spades"
    case hearts = "hearts"
    case diamonds = "diamonds"
    case clubs = "clubs"
    
    func getIcon() -> ImageResource {
        switch self {
        case .spades:
            ImageResource.spades
        case .hearts:
            ImageResource.hearts
        case .diamonds:
            ImageResource.diamonds
        case .clubs:
            ImageResource.clubs
        }
    }
    
    func getCards() -> [Card] {
        var result: [Card] = []
        for value in CardValue.allCases {
            result.append(Card(suit: self, value: value))
        }
        return result
    }
}

enum CardValue: String, CaseIterable {
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
}
