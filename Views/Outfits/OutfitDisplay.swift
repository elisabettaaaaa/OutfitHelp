import SwiftUI


struct OutfitDisplay: View {
    let items: [ClothingItem]
    let scale: CGFloat

    var orderedItems: [ClothingItem] {
        let order: [ClothingCategory] = [.outerwear, .tops, .dresses, .skirts, .bottoms, .shoes, .accessories]
        return order.compactMap { cat in items.first(where: { $0.category == cat }) }
    }

    func heightRatio(for category: ClothingCategory) -> CGFloat {
        switch category {
        case .outerwear:   return 0.16
        case .tops:        return 0.11       // Magliette più piccole!
        case .dresses:     return 0.28
        case .skirts:      return 0.13
        case .bottoms:     return 0.20       // Pantaloni più grandi
        case .shoes:       return 0.10
        case .accessories: return 0.09
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 8.0 * scale) {
                ForEach(orderedItems, id: \.id) { item in
                    if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                        let totalRatio = orderedItems.map { heightRatio(for: $0.category) }.reduce(0, +)
                        let categoryHeight = geometry.size.height * (heightRatio(for: item.category) / totalRatio)
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: categoryHeight)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
