import SwiftUI
import PhotosUI

struct ImageBlock: View {
    @ObservedObject var settings = AppSettings.shared
    
    var body: some View {
        PhotosPicker(selection: $settings.userImageAsset, maxSelectionCount: 1, matching: .images) {
            content
        }
        .padding(.bottom, 32.adoption())
        .onChange(of: settings.userImageAsset) { newValue in
            Task {
                if let loaded = try? await newValue.first?.loadTransferable(type: Image.self) {
                    settings.userImage = FileDownloader.resizeImage(image: loaded.asUIImage(),
                                                            targetSize: CGSize(width: 100, height: 100))
                    try await FileDownloader.savePhotosPickerItemsToFileManager(items: settings.userImageAsset)
                } else { print("Failed") }
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            if let userImage = settings.userImage {
                Image(uiImage: userImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64.adoption(), height: 64.adoption())
                    .clipped()
                    .clipShape(Circle())
                    .zIndex(4)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.white)
                    .frame(width: 30.adoption(), height: 30.adoption())
                    .frame(width: 64.adoption(), height: 64.adoption())
                    .background(Color.white.opacity(0.5))
                    .clipped()
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .inset(by: 1)
                            .stroke(.white.opacity(0.5), lineWidth: 2.adoption())
                    )
            }
        }
        .overlay(alignment: . bottomTrailing) {
            Image(.cameraIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 12.adoption(), height: 12.adoption())
                .clipped()
                .frame(width: 24.adoption(), height: 24.adoption())
                .background(LinearGradient.greenGradient)
                .clipShape(.circle)
                .overlay(content: {
                    Circle()
                        .inset(by: 1)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2.adoption())
                })
        }
        .zIndex(4)
    }
}

#Preview {
    ImageBlock()
}
