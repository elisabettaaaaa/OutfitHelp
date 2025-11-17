import SwiftUI

/// Componente condiviso per visualizzare outfit con proporzioni realistiche
struct OutfitDisplay: View {
    let items: [ClothingItem]
    let scale: CGFloat
    
    var orderedItems: [ClothingItem] {
        let order: [ClothingCategory] = [.outerwear, .tops, .dresses, .skirts, .bottoms, .shoes, .accessories]
        return order.compactMap { cat in items.first(where: { $0.category == cat }) }
    }
    
    // Dimensioni base per ogni categoria (alla scala 1.0, adattato per card media)
    func itemSize(for category: ClothingCategory, containerHeight: CGFloat) -> CGSize {
        // containerHeight = altezza card, es. 170
        switch category {
        case .tops:
            return CGSize(width: containerHeight * 0.45 * scale, height: containerHeight * 0.20 * scale)
        case .outerwear:
            return CGSize(width: containerHeight * 0.50 * scale, height: containerHeight * 0.22 * scale)
        case .dresses:
            return CGSize(width: containerHeight * 0.48 * scale, height: containerHeight * 0.40 * scale)
        case .skirts:
            return CGSize(width: containerHeight * 0.42 * scale, height: containerHeight * 0.18 * scale)
        case .bottoms:
            return CGSize(width: containerHeight * 0.40 * scale, height: containerHeight * 0.25 * scale)
        case .shoes:
            return CGSize(width: containerHeight * 0.35 * scale, height: containerHeight * 0.12 * scale)
        case .accessories:
            return CGSize(width: containerHeight * 0.25 * scale, height: containerHeight * 0.08 * scale)
        }
    }

    // Spacing tra i capi rivisto: limiti bassi alla sovrapposizione, valori pensati per card non full screen
    func itemSpacing(for category: ClothingCategory, isFirst: Bool) -> CGFloat {
        if isFirst { return 0 }
        switch category {
        case .outerwear:      return -10 * scale
        case .tops:           return -14 * scale
        case .dresses:        return -8 * scale
        case .skirts:         return 6 * scale
        case .bottoms:        return -10 * scale
        case .shoes:          return 0
        case .accessories:    return -20 * scale
        }
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
