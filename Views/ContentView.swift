import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WardrobeViewModel()
    @State private var showClothesSheet = false
    @State private var showOutfitSheet = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomTabBar(selectedTab: $viewModel.selectedTab)
                    .padding(.horizontal)
                    .padding(.top, 8)

                if viewModel.selectedTab == .clothes {
                    ClothesGridView(clothingItems: $viewModel.clothingItems, viewModel: viewModel)
                } else {
                    OutfitGridView(outfits: viewModel.outfits, viewModel: viewModel)
                }
                Spacer()
            }
            .overlay(alignment: .bottom) {
                AddButton {
                    if viewModel.selectedTab == .clothes {
                        showClothesSheet = true
                    } else {
                        showOutfitSheet = true
                    }
                }
                .padding(.bottom, 40)
            }
            .sheet(isPresented: $showClothesSheet) {
                AddClothingView(viewModel: viewModel)
            }
            .sheet(isPresented: $showOutfitSheet) {
                CreateOutfitView(viewModel: viewModel)
            }
        }
    }
}

