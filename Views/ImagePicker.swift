import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let sourceType: UIImagePickerController.SourceType
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        print("ImagePicker: makeUIViewController chiamato con sourceType:", sourceType == .camera ? "camera" : "photoLibrary")
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Verifica la disponibilità della sorgente
        if sourceType == .camera && !UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("ImagePicker: ERRORE - Camera non disponibile su questo dispositivo (probabilmente simulatore)")
            print("ImagePicker: Uso photoLibrary come fallback")
            picker.sourceType = .photoLibrary
        } else if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            picker.sourceType = sourceType
            print("ImagePicker: sourceType impostato correttamente a:", sourceType == .camera ? "camera" : "photoLibrary")
        } else {
            print("ImagePicker: ATTENZIONE - sourceType non disponibile, uso photoLibrary")
            picker.sourceType = .photoLibrary
        }
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Debug: preferisco NON mettere print qui perché viene chiamato molte volte
    }

    func makeCoordinator() -> Coordinator {
        print("ImagePicker: makeCoordinator chiamato")
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("ImagePicker: didFinishPickingMediaWithInfo chiamato")
            if let uiImage = info[.originalImage] as? UIImage {
                print("ImagePicker: UIIMAGE selezionata")
                parent.image = uiImage
            } else {
                print("ImagePicker: immagini NON selezionata")
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("ImagePicker: Scelta immagine ANNULLATA")
            parent.dismiss()
        }
    }
}

