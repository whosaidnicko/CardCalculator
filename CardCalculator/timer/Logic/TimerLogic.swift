import Foundation
import Combine

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var currentLevel: Int = 1
    @Published var currentTime: TimeInterval = AppSettings.shared.tournamentTimer.getMins() // 15 minutes in seconds
    @Published var nextLevelTime: TimeInterval = AppSettings.shared.tournamentTimer.getMins() // Next level in 15 minutes
    @Published var totalTime: TimeInterval = 0 // Total accumulated tournament time
    @Published var currentBlinds: String = "100/200"
    @Published var nextBlinds: String = "200/400"
    @Published var isRunning: Bool = false

    private var timer: AnyCancellable?
    
    private let blindStructure: [(small: Int, big: Int)] = [
        (100, 200), (200, 400), (300, 600), (400, 800), (500, 1000),
        (600, 1200), (800, 1600), (1000, 2000), (1500, 3000), (2000, 4000)
    ]

    func startTimer() {
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }

    func stopTimer() {
        isRunning = false
        timer?.cancel()
    }

    func resetTimer() {
        stopTimer()
        currentLevel = 1
        currentTime = 900
        nextLevelTime = 900
        totalTime = 0
        updateBlinds()
    }

    private func updateTimer() {
        guard currentTime > 0 else {
            advanceLevel()
            return
        }
        
        currentTime -= 1
        totalTime += 1
        nextLevelTime -= 1
        
        if nextLevelTime <= 0 {
            advanceLevel()
        }
    }

    private func advanceLevel() {
        if currentLevel < blindStructure.count {
            currentLevel += 1
        }
        currentTime = 900
        nextLevelTime = 900
        updateBlinds()
    }

    private func updateBlinds() {
        let current = blindStructure[min(currentLevel - 1, blindStructure.count - 1)]
        let next = blindStructure[min(currentLevel, blindStructure.count - 1)]
        
        currentBlinds = "\(current.small)/\(current.big)"
        nextBlinds = "\(next.small)/\(next.big)"
    }

    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
