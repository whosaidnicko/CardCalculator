import SwiftUI
import PhotosUI

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    private init() {
        self.userImage = FileDownloader.loadImagesFromFileManager(from: "image.jpg")
    }
    
    @Published var userImage: UIImage?
    @Published var userImageAsset: [PhotosPickerItem] = []
    
    @AppStorage("isNotificationOn") var isNotificationOn: Bool = false {
        didSet {
            if isNotificationOn {
                NotificationsSet.shared.requestPermission  { status in
                    if !status {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isNotificationOn = false
                        }
                    }
                }
            }
        }
    }
    @AppStorage("tournamentTimer") var tournamentTimer: TournamentType = .fifteen
    
    @AppStorage("name") var name: String = ""
    @AppStorage("login") var login: String = ""
}
