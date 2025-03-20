import Foundation
class CalculatorViewModel: ObservableObject {
    @Published var myCards: [Card?] = Array(repeating: nil, count: 2)
    @Published var tableCards: [Card?] = Array(repeating: nil, count: 5)
    
    @Published var winningProbability: Double = 0
    @Published var draw: Double = 0
    @Published var losing: Double = 0

    @Published var flush: Double = 0
    @Published var straight: Double = 0
    @Published var twoPairs: Double = 0
    
    func calculateAction() {
        guard myCards.compactMap({$0}).count == 2 && tableCards.compactMap({$0}).count > 2 else { return }
        let hand = getValidHand()
        guard !hand.isEmpty else { return }
        
        let deck = createDeck(excluding: hand)
        let simulations = 10000
        var winCount = 0
        var drawCount = 0
        var lossCount = 0
        
        var flushCount = 0
        var straightCount = 0
        var twoPairCount = 0
        
        for _ in 0..<simulations {
            let opponentHand = drawRandomHand(from: deck)
            let remainingTable = drawRandomCards(from: deck, count: 5 - tableCards.compactMap { $0 }.count)
            let finalMyHand = hand + remainingTable
            let finalOpponentHand = opponentHand + remainingTable
            
            let myBestHand = evaluateBestHand(cards: finalMyHand)
            let opponentBestHand = evaluateBestHand(cards: finalOpponentHand)
            
            if myBestHand > opponentBestHand {
                winCount += 1
            } else if myBestHand == opponentBestHand {
                drawCount += 1
            } else {
                lossCount += 1
            }
            
            if hasFlush(cards: finalMyHand) { flushCount += 1 }
            if hasStraight(cards: finalMyHand) { straightCount += 1 }
            if hasTwoPair(cards: finalMyHand) { twoPairCount += 1 }
        }
        
        winningProbability = Double(winCount) / Double(simulations)
        draw = Double(drawCount) / Double(simulations)
        losing = 1 - draw - winningProbability
        
        flush = Double(flushCount) / Double(simulations)
        straight = Double(straightCount) / Double(simulations)
        twoPairs = Double(twoPairCount) / Double(simulations)
    }
    
    private func getValidHand() -> [Card] {
        return (myCards + tableCards).compactMap { $0 }
    }
    
    private func createDeck(excluding cards: [Card]) -> [Card] {
        return CardSuit.allCases.flatMap { $0.getCards() }.filter { !cards.contains($0) }
    }
    
    private func drawRandomHand(from deck: [Card]) -> [Card] {
        return Array(deck.shuffled().prefix(2))
    }
    
    private func drawRandomCards(from deck: [Card], count: Int) -> [Card] {
        return Array(deck.shuffled().prefix(count))
    }
    
    private func evaluateBestHand(cards: [Card]) -> Int {

        if hasFlush(cards: cards) { return 6 }
        if hasStraight(cards: cards) { return 5 }
        if hasTwoPair(cards: cards) { return 3 }
        return 1 // High card
    }
    
    private func hasFlush(cards: [Card]) -> Bool {
        let suitCounts = Dictionary(grouping: cards, by: { $0.suit }).mapValues { $0.count }
        return suitCounts.values.contains(where: { $0 >= 5 })
    }
    
    private func hasStraight(cards: [Card]) -> Bool {
        let sortedValues = cards.map { $0.value.rawValue }.sorted()
        return sortedValues.containsSubsequence(of: ["A", "2", "3", "4", "5"]) ||
               sortedValues.containsSubsequence(of: ["10", "J", "Q", "K", "A"])
    }
    
    private func hasTwoPair(cards: [Card]) -> Bool {
        let valueCounts = Dictionary(grouping: cards, by: { $0.value }).mapValues { $0.count }
        return valueCounts.values.filter { $0 >= 2 }.count >= 2
    }
}

extension Array where Element: Comparable {
    func containsSubsequence(of sequence: [Element]) -> Bool {
        return sequence.allSatisfy { self.contains($0) }
    }
}
