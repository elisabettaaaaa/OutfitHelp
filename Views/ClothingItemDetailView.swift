import SwiftUI

struct ClothingItemDetailView: View {
    let item: ClothingItem
    @ObservedObject var viewModel: WardrobeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Immagine del capo
                    if let imageData = item.imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 400)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 8)
                    }
                    
                    // Dettagli del capo
                    VStack(alignment: .leading, spacing: 20) {
                        // Nome
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nome")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .textCase(.uppercase)
                            Text(item.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                        
                        // Categoria
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Categoria")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                Text(item.category.rawValue)
                                    .font(.body)
                            }
                            
                            Spacer()
                            
                            // Icona categoria
                            Image(systemName: categoryIcon(for: item.category))
                                .font(.system(size: 32))
                                .foregroundColor(.gray.opacity(0.6))
                        }
                        
                        Divider()
                        
                        // Colore
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Colore")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .textCase(.uppercase)
                            Text(item.color.isEmpty ? "Non specificato" : item.color)
                                .font(.body)
                                .foregroundColor(item.color.isEmpty ? .secondary : .primary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Dettagli Capo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Chiudi") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .alert("Elimina Capo", isPresented: $showDeleteAlert) {
                Button("Annulla", role: .cancel) { }
                Button("Elimina", role: .destructive) {
                    viewModel.deleteClothingItem(item)
                    dismiss()
                }
            } message: {
                Text("Sei sicuro di voler eliminare \"\(item.name)\"? Questa azione non può essere annullata.")
            }
        }
    }
    
    // Funzione helper per icone categoria
    private func categoryIcon(for category: ClothingCategory) -> String {
        switch category {
        case .tops:
            return "tshirt"
        case .bottoms:
            return "square.stack"
        case .skirts:
            return "triangle"
        case .dresses:
            return "figure.dress.line.vertical.figure"
        case .outerwear:
            return "jacket"
        case .shoes:
            return "shoeprints.fill"
        case .accessories:
            return "bag"
        }
    }
}
