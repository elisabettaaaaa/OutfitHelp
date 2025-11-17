import Foundation
import SwiftUI
import Combine

class WardrobeViewModel: ObservableObject {
    @Published var clothingItems: [ClothingItem] = [] {
        didSet { persistClothes() }
    }
    @Published var outfits: [Outfit] = [] {
        didSet { persistOutfits() }
    }
    @Published var selectedTab: WardrobeTab = .clothes

    // MARK: - Persistenza file

    private let clothesURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("clothingItems.json")
    private let outfitsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("outfits.json")

    init() {
        loadClothes()
        loadOutfits()
    }

    // ——— METODI CRUD ———

    func addClothingItem(_ item: ClothingItem) {
        clothingItems.append(item)
    }
    func deleteClothingItem(_ item: ClothingItem) {
        clothingItems.removeAll(where: { $0.id == item.id })
    }
    func addOutfit(_ outfit: Outfit) {
        outfits.append(outfit)
    }
    func deleteOutfit(_ outfit: Outfit) {
        outfits.removeAll(where: { $0.id == outfit.id })
    }

    // ——— SALVATAGGIO E LETTURA ———

    private func persistClothes() {
        do {
            let data = try JSONEncoder().encode(clothingItems)
            try data.write(to: clothesURL)
        } catch {
            print("Errore salvataggio clothes:", error)
        }
    }
    private func persistOutfits() {
        do {
            let data = try JSONEncoder().encode(outfits)
            try data.write(to: outfitsURL)
        } catch {
            print("Errore salvataggio outfits:", error)
        }
    }
    private func loadClothes() {
        do {
            let data = try Data(contentsOf: clothesURL)
            clothingItems = try JSONDecoder().decode([ClothingItem].self, from: data)
        } catch {
            clothingItems = []
        }
    }
    private func loadOutfits() {
        do {
            let data = try Data(contentsOf: outfitsURL)
            outfits = try JSONDecoder().decode([Outfit].self, from: data)
        } catch {
            outfits = []
        }
    }
}

