import SwiftUI

/// Componente condiviso per visualizzare outfit con proporzioni realistiche
struct OutfitDisplay: View {
    let items: [ClothingItem]
    let scale: CGFloat // Moltiplicatore per le dimensioni (1.0 = full screen, 0.3 = miniatura)
    
    var orderedItems: [ClothingItem] {
        let order: [ClothingCategory] = [.outerwear, .tops, .dresses, .skirts, .bottoms, .shoes, .accessories]
        return order.compactMap { cat in items.first(where: { $0.category == cat }) }
    }
    
    // Dimensioni base per ogni categoria (alla scala 1.0)
    func itemSize(for category: ClothingCategory, containerHeight: CGFloat) -> CGSize {
        let height = containerHeight
        
        switch category {
        case .tops:
            return CGSize(width: height * 0.45 * scale, height: height * 0.30 * scale)
        case .outerwear:
            return CGSize(width: height * 0.50 * scale, height: height * 0.35 * scale)
        case .dresses:
            return CGSize(width: height * 0.48 * scale, height: height * 0.55 * scale)
        case .skirts:
            return CGSize(width: height * 0.42 * scale, height: height * 0.30 * scale)
        case .bottoms:
            return CGSize(width: height * 0.40 * scale, height: height * 0.38 * scale)
        case .shoes:
            return CGSize(width: height * 0.35 * scale, height: height * 0.20 * scale)
        case .accessories:
            return CGSize(width: height * 0.25 * scale, height: height * 0.18 * scale)
        }
    }
    
    // Spacing tra i capi (valori negativi = sovrapposizione)
    func itemSpacing(for category: ClothingCategory, isFirst: Bool) -> CGFloat {
        if isFirst { return 0 }
        
        let baseSpacing: CGFloat
        
        switch category {
        case .outerwear:
            baseSpacing = -35
        case .tops:
            baseSpacing = -40 // I pantaloni iniziano dalla vita del top
        case .dresses:
            baseSpacing = -25
        case .skirts:
            baseSpacing = 10 // Margine positivo sotto la gonna
        case .bottoms:
            baseSpacing = -35 // Le scarpe iniziano dal fondo dei pantaloni
        case .shoes:
            baseSpacing = 0
        case .accessories:
            baseSpacing = -60
        }
        
        return baseSpacing * scale
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 0) {
                    ForEach(Array(orderedItems.enumerated()), id: \.element.id) { index, item in
                        if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                            let size = itemSize(for: item.category, containerHeight: geometry.size.height)
                            let spacing = itemSpacing(for: item.category, isFirst: index == 0)
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width, height: size.height)
                                .padding(.top, spacing)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
        }
    }
}
