//
//  AddClothingViewModel.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 11/11/25.
//

//  AddClothingViewModel.swift
//  outfit creation

import Foundation
import SwiftUI
import Combine

class AddClothingViewModel: ObservableObject {
    @Published var pickedImage: UIImage?
    @Published var processedImage: UIImage?
    @Published var errorMsg: String?
    @Published var isProcessing: Bool = false

    func pickAndRemoveBackground(image: UIImage) {
        isProcessing = true
        errorMsg = nil
        BackgroundRemover.removeBackground(from: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.isProcessing = false
                switch result {
                case .success(let img):
                    self?.processedImage = img
                    self?.errorMsg = nil
                case .failure:
                    self?.processedImage = nil
                    self?.errorMsg = "Errore durante la rimozione dello sfondo. Scegli un'altra foto."
                }
            }
        }
    }
}
