//
//  CreateOutfitView.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 12/11/25.
//

import SwiftUI

struct CreateOutfitView: View {
    @ObservedObject var viewModel: WardrobeViewModel
    @Environment(\.dismiss) var dismiss

    @State private var selectedItems: [ClothingItem] = []
    @State private var outfitName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nome Outfit")) {
                    TextField("Nome", text: $outfitName)
                }
                Section(header: Text("Seleziona capi da abbinare")) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.clothingItems) { item in
                                ClothingItemCard(item: item)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedItems.contains(where: { $0.id == item.id }) ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        if selectedItems.contains(where: { $0.id == item.id }) {
                                            selectedItems.removeAll(where: { $0.id == item.id })
                                        } else {
                                            selectedItems.append(item)
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Crea Outfit")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva") {
                        let outfit = Outfit(name: outfitName, clothingItems: selectedItems)
                        viewModel.addOutfit(outfit)
                        dismiss()
                    }
                    .disabled(outfitName.isEmpty || selectedItems.isEmpty)
                }
            }
        }
    }
}
