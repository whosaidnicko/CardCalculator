import SwiftUI

@main
struct CardCalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authService = AuthService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
                .onAppear { authService.regularSignOut(completion: { _ in }) }
        }
    }
}
