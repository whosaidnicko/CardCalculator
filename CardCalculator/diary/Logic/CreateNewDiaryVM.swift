import Foundation

class CreateNewDiaryVM: ObservableObject {
    
    @Published var selectedGameType: GameType = .texas
    @Published var isWinning: Bool = true
    @Published var amount: String = ""
    
    
    @Published var duration: String = ""
    @Published var selectedTableType: TableType = .cash
    @Published var hands: String = ""
    @Published var notes: String = ""
    
    let storage = StorageViewModel.shared
    
    var isValid: Bool {
        !amount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !duration.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !hands.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func saveAction(gameEntity: GameEntity?) {
        let amountNumber: Int = Int(amount) ?? 0
        let durationNumber: Double = Double(duration) ?? 0
        let handsNumber: Int = Int(hands) ?? 0
        
        
        if let gameEntity {
            let _ = storage.updateGame(id: gameEntity.id,
                                       amount: amountNumber,
                                       duration: durationNumber,
                                       hands: handsNumber,
                                       isWinning: isWinning,
                                       notes: notes,
                                       tableType: selectedTableType,
                                       gameType: selectedGameType,
                                       userName: "")
        } else {
            let _ = storage.addGame(amount: amountNumber,
                                    duration: durationNumber,
                                    hands: handsNumber,
                                    isWinning: isWinning,
                                    notes: notes,
                                    tableType: selectedTableType,
                                    gameType: selectedGameType,
                                    userName: "")
        }
    }
    
    func deleteAction(gameEntity: GameEntity?) {
        guard let gameEntity else {
            debugPrint("Not selected game")
            return
        }
        storage.deleteGame(entity: gameEntity)
    }
}
