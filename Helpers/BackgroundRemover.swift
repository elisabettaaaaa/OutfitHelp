import Foundation
import Vision
import CoreImage
import UIKit

enum BackgroundRemoverError: Error {
    case removalFailed
    case conversionFailed
}

class BackgroundRemover {
    static func removeBackground(from image: UIImage, completion: @escaping (Result<UIImage, Error>) -> Void) {
        print("BackgroundRemover: iniziato processing")
        guard let cgImage = image.cgImage else {
            print("BackgroundRemover: conversione cgImage FALLITA")
            completion(.failure(BackgroundRemoverError.conversionFailed))
            return
        }

        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                print("BackgroundRemover: performing Vision request")
                try handler.perform([request])
                guard let result = request.results?.first as? VNInstanceMaskObservation else {
                    print("BackgroundRemover: nessuna mask risultante!")
                    DispatchQueue.main.async {
                        completion(.failure(BackgroundRemoverError.removalFailed))
                    }
                    return
                }

                let maskedPixelBuffer = try result.generateMaskedImage(
                    ofInstances: result.allInstances,
                    from: handler,
                    croppedToInstancesExtent: true
                )

                let outputCIImage = CIImage(cvPixelBuffer: maskedPixelBuffer)
                let context = CIContext()
                if let cgOutput = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
                    let outputUIImage = UIImage(cgImage: cgOutput)
                    print("BackgroundRemover: image con bg rimosso OK")
                    DispatchQueue.main.async {
                        completion(.success(outputUIImage))
                    }
                } else {
                    print("BackgroundRemover: creazione cgOutput FALLITA")
                    DispatchQueue.main.async {
                        completion(.failure(BackgroundRemoverError.removalFailed))
                    }
                }
            } catch {
                print("BackgroundRemover: errore Vision", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

