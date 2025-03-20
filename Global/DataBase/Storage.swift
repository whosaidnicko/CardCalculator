import Foundation
import CoreData

class StorageViewModel: ObservableObject {
    static let shared = StorageViewModel()
    
    let container: NSPersistentContainer
    
    @Published var savedGames: [GameEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "SessionsContainer")
        container.loadPersistentStores { description, error in
            if let error {
                debugPrint("Error leading core data. \(error)")
            } else {
                debugPrint("Successfully loaded core data.")
            }
        }
        
        fetchGames()
    }
    
    func findGameById(id: UUID?) -> GameEntity? {
        guard let id else { return nil }
        return savedGames.first(where: { $0.id == id })
    }
    
    func fetchGames() {
        let request = NSFetchRequest<GameEntity>(entityName: "GameEntity")
        
        do {
            savedGames = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching. \(error)")
        }
    }
    
    func saveGameData() {
        do {
            try container.viewContext.save()
            fetchGames()
        } catch let error {
            debugPrint("Error \(error).")
        }
    }
    
    func addGame(
        id: UUID? = nil,
        amount: Int,
        duration: Double,
        hands: Int,
        isWinning: Bool,
        notes: String,
        tableType: TableType,
        gameType: GameType,
        userName: String
    ) -> UUID? {
        let newGame = GameEntity(context: container.viewContext)
        if let id { newGame.id = id }
        else { newGame.id = UUID() }
        
        newGame.amount = Int32(amount)
        newGame.duration = duration
        newGame.hands = Int16(hands)
        newGame.isWinning = isWinning
        newGame.notes = notes
        newGame.tableType = tableType.rawValue
        newGame.gameType = gameType.rawValue
        newGame.date = Date()
        newGame.userName = userName
        
        saveGameData()
        debugPrint("Created Game with id: \(String(describing: newGame.id))")
        
        return newGame.id
    }
    
    func updateGame(
        id: UUID?,
        amount: Int? = nil,
        duration: Double? = nil,
        hands: Int? = nil,
        isWinning: Bool? = nil,
        notes: String? = nil,
        tableType: TableType? = nil,
        gameType: GameType? = nil,
        userName: String? = nil
    ) {
        guard let id, let entity = findGameById(id: id) else { return }

        entity.id = UUID()
        if let amount { entity.amount = Int32(amount) }
        if let duration { entity.duration = duration }
        if let hands { entity.hands = Int16(hands) }
        if let isWinning { entity.isWinning = isWinning }
        if let notes { entity.notes = notes }
        if let tableType { entity.tableType = tableType.rawValue }
        if let gameType { entity.gameType = gameType.rawValue }
        if let userName { entity.userName = userName }
        
        saveGameData()
        objectWillChange.send()
        debugPrint("Updated Game with id: \(id)")
    }
    
    func deleteGame(id: UUID? = nil, entity: GameEntity? = nil) {
        if let id, let entity = findGameById(id: id) {
            container.viewContext.delete(entity)
            debugPrint("Deleted Game with id: \(id)")
        } else if let entity {
            container.viewContext.delete(entity)
            debugPrint("Deleted Game by entity: with id = \(String(describing: id))")
        } else {
            debugPrint("Game was not deleted")
        }
        
        saveGameData()
    }
}
