//
//  ClothingItem.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 07/11/25.
//

//
//  ClothingItem.swift
//  VirtualWardrobe
//
//  Modello per rappresentare un capo di abbigliamento
//

import Foundation

struct ClothingItem: Identifiable, Codable {
    let id: UUID
    var name: String
    var category: ClothingCategory
    var color: String
    var imageData: Data?
    
    init(
        id: UUID = UUID(),
        name: String,
        category: ClothingCategory,
        color: String,
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.color = color
        self.imageData = imageData
    }
}
