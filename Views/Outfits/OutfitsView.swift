//
//  OutfitsView.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 10/11/25.
//

import SwiftUI

struct OutfitsView: View {
    @ObservedObject var wardrobeViewModel: WardrobeViewModel
    @StateObject private var builderViewModel = OutfitBuilderViewModel()
    @State private var showPreview = false

    var body: some View {
        VStack {
            Text("Crea il tuo Outfit")
                .font(.title2)
                .padding(.top)
            Text("Seleziona uno o più capi per visualizzare l'outfit")
                .foregroundColor(.secondary)
                .padding(.top)
            
            // Selezione capi
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(wardrobeViewModel.clothingItems) { item in
                        ClothingItemCard(item: item)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(builderViewModel.selectedItems.contains(where: {$0.id == item.id}) ? Color.blue : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                builderViewModel.toggleItem(item)
                            }
                            .frame(width: 80, height: 80)
                    }
                }
                .padding()
            }

            Spacer()

            // Preview Outfit
            if !builderViewModel.selectedItems.isEmpty {
                OutfitPreviewView(items: builderViewModel.selectedItems)
                    .padding(.bottom)
                Button("Salva Outfit") {
                    showPreview = true
                }
                
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            }
            
        }
        .sheet(isPresented: $showPreview) {
            OutfitPreviewView(items: builderViewModel.selectedItems)
        }
    }
}

#Preview {
    // Crea un ViewModel con capi di esempio
    let viewModel = WardrobeViewModel()
    viewModel.clothingItems = [
        ClothingItem(name: "T-Shirt Bianca", category: .tops, color: "Bianco"),
        ClothingItem(name: "Jeans Blu", category: .bottoms, color: "Blu"),
        ClothingItem(name: "Giacca", category: .outerwear, color: "Nero")
    ]
    return OutfitsView(wardrobeViewModel: viewModel)
}
