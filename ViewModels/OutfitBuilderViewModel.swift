//
//  OutfitBuilderViewModel.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 10/11/25.
//

import SwiftUI
import Combine

class OutfitBuilderViewModel: ObservableObject {
    @Published var selectedItems: [ClothingItem] = []

    // Funzione per aggiungere/rimuovere capi selezionati
    func toggleItem(_ item: ClothingItem) {
        if let idx = selectedItems.firstIndex(where: { $0.id == item.id }) {
            selectedItems.remove(at: idx)
        } else {
            selectedItems.append(item)
        }
    }

    // Raggruppa i capi per categoria per visualizzarli in ordine verticale
    var categorizedItems: [ClothingCategory: ClothingItem] {
        var dict = [ClothingCategory: ClothingItem]()
        for item in selectedItems {
            dict[item.category] = item
        }
        return dict
    }
}
