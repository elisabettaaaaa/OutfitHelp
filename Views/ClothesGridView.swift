import SwiftUI

struct ClothesGridView: View {
    @Binding var clothingItems: [ClothingItem]
    @State private var selectedItem: ClothingItem?
    @ObservedObject var viewModel: WardrobeViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            if clothingItems.isEmpty {
                EmptyStateView()
                    .padding(.top, 60)
            } else {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(clothingItems) { item in
                        ClothingItemCard(item: item)
                            .onTapGesture {
                                selectedItem = item
                            }
                    }
                }
                .padding(16)
            }
        }
        .sheet(item: $selectedItem) { item in
            ClothingItemDetailView(item: item, viewModel: viewModel)
        }
    }
}
