//
//  Models.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 12/11/25.
//

// Models/Outfit.swift
import Foundation

struct Outfit: Identifiable, Codable {
    let id: UUID
    var name: String
    var clothingItems: [ClothingItem]

    init(id: UUID = UUID(), name: String, clothingItems: [ClothingItem]) {
        self.id = id
        self.name = name
        self.clothingItems = clothingItems
    }
}
