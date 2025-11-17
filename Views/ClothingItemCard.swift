//
//  ClothingItemCard.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  ClothingItemCard.swift
//  VirtualWardrobe
//
//  Componente per la visualizzazione di un capo di abbigliamento
//

import SwiftUI

struct ClothingItemCard: View {
    let item: ClothingItem
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sfondo trasparente invece di grigio
                Color.clear
                
                if let imageData = item.imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                } else {
                    // Placeholder per capi senza immagine
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                    Text(item.name)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
#Preview {
    ClothingItemCard(
        item: ClothingItem(
            name: "T-Shirt",
            category: .tops,
            color: "Bianco"
            // Puoi anche aggiungere un'immagine di test se vuoi provarla:
            // imageData: UIImage(named: "nomeImmagine")?.jpegData(compressionQuality: 0.8)
        )
    )
    .frame(width: 120, height: 120)
    .padding()
}
