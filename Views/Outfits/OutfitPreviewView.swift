import SwiftUI

struct OutfitPreviewView: View {
    let outfit: Outfit?
    let items: [ClothingItem]
    var viewModel: WardrobeViewModel?
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    
    // Inizializzatore principale per outfit salvati
    init(outfit: Outfit, viewModel: WardrobeViewModel) {
        self.outfit = outfit
        self.items = outfit.clothingItems
        self.viewModel = viewModel
    }
    
    // Inizializzatore alternativo per anteprime temporanee
    init(items: [ClothingItem]) {
        self.outfit = nil
        self.items = items
        self.viewModel = nil
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Sfondo
            Color.white.opacity(0.97)
                .ignoresSafeArea()
            
            // Outfit usando il componente condiviso con scale 1.0 (full screen)
            OutfitDisplay(items: items, scale: 1.0)
                .padding(.vertical, 40)
            
            // Pulsante elimina elegante (solo per outfit salvati)
            if let outfit = outfit, let viewModel = viewModel {
                Button(action: {
                    showDeleteAlert = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 56, height: 56)
                            .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
                        
                        Image(systemName: "trash.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 24)
                .padding(.bottom, 40)
                .alert("Elimina Outfit", isPresented: $showDeleteAlert) {
                    Button("Annulla", role: .cancel) { }
                    Button("Elimina", role: .destructive) {
                        viewModel.deleteOutfit(outfit)
                        dismiss()
                    }
                } message: {
                    Text("Sei sicuro di voler eliminare questo outfit? Questa azione non può essere annullata.")
                }
            }
        }
    }
}

