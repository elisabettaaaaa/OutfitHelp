import SwiftUI

struct OutfitGridView: View {
    let outfits: [Outfit]
    @State private var selectedOutfit: Outfit?
    @ObservedObject var viewModel: WardrobeViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            if outfits.isEmpty {
                VStack(spacing: 16) {
                    Text("👗")
                        .font(.system(size: 48))
                    Text("Nessun outfit disponibile")
                        .font(.headline)
                }
                .padding(.top, 60)
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(outfits) { outfit in
                        PreviewCardOutfitGrid(items: outfit.clothingItems)
                            .frame(width: 110, height: 145)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 1)
                            .onTapGesture {
                                selectedOutfit = outfit
                            }
                    }
                }
                .padding(16)
            }
        }
        .sheet(item: $selectedOutfit) { outfit in
            OutfitPreviewView(outfit: outfit, viewModel: viewModel)
        }
    }
}

// CARD: miniature outfit nella griglia
struct PreviewCardOutfitGrid: View {
    let items: [ClothingItem]

    var body: some View {
        // Usa lo stesso componente OutfitDisplay con scale ridotto per le miniature
        OutfitDisplay(items: items, scale: 0.25)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
    }
}

