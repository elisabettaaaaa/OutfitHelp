import AVFoundation
import UIKit

class CameraPermissionHelper {
    static func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Permesso già concesso
            completion(true)
            
        case .notDetermined:
            // Richiedi il permesso
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
            
        case .denied, .restricted:
            // Permesso negato o limitato
            completion(false)
            
        @unknown default:
            completion(false)
        }
    }
    
    static func showPermissionDeniedAlert(on viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Permesso Fotocamera Necessario",
            message: "Per scattare foto, abilita l'accesso alla fotocamera nelle Impostazioni",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Apri Impostazioni", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Annulla", style: .cancel))
        
        viewController.present(alert, animated: true)
    }
}
