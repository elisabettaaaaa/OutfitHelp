import SwiftUI

struct OutfitGridView: View {
    let outfits: [Outfit]
    @State private var selectedOutfit: Outfit?
    @ObservedObject var viewModel: WardrobeViewModel

    // Tre colonne, flessibili!
    private let columns = [
        GridItem(.flexible(), spacing: 18),
        GridItem(.flexible(), spacing: 18),
        GridItem(.flexible(), spacing: 18)
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
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(outfits) { outfit in
                        PreviewCardOutfitGrid(items: outfit.clothingItems)
                            .frame(width: 110, height: 170)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
                            .onTapGesture {
                                selectedOutfit = outfit
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
            }
        }
        .sheet(item: $selectedOutfit) { outfit in
            OutfitPreviewView(outfit: outfit, viewModel: viewModel)
        }
    }
}

struct PreviewCardOutfitGrid: View {
    let items: [ClothingItem]

    var body: some View {
        OutfitDisplay(items: items, scale: 1.0) 
            .padding(14)
    }
}

