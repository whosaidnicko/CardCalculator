import PhotosUI
import SwiftUI

class FileDownloader {
    static func savePhotosPickerItemsToFileManager(items: [PhotosPickerItem]) async throws -> String? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        if !fileManager.fileExists(atPath: documentsDirectory.path) {
            try fileManager.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        var imageName: String?
        
        let item = items.first
        if let data = try await item?.loadTransferable(type: Data.self) {
            let fileName = "image.jpg"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            try data.write(to: fileURL)
            imageName = fileName
            print("Saved file to: \(fileURL.path)")
        } else {
            print("Failed to load data for item: \(String(describing: item))")
        }
        
        return imageName
    }
    
    static func loadImagesFromFileManager(from imageName: String?) -> UIImage? {
        guard let imageName else { return nil }
        var imageResult: UIImage?
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        if let documentsDirectory = documentsDirectory {
            let imageURL = documentsDirectory.appendingPathComponent(imageName)
            if let image = UIImage(contentsOfFile: imageURL.path) {
                let resizedImage = FileDownloader.resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
                imageResult = resizedImage
            }
        }
        
        return imageResult
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
struct Swiper: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
//            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                                      self.offset = value.translation
                                  }
                                  .onEnded { value in
                                      if value.translation.width > 70 {
                                          onDismiss()
                                  
                                      }
                                      self.offset = .zero
                                  }
            )
    }
}
extension View {
    func ribkamechti() -> some View {
        self.modifier(Voteazbucum())
    }
    
}
