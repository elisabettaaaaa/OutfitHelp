import SwiftUI

struct AddClothingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: WardrobeViewModel

    @State private var name = ""
    @State private var selectedCategory: ClothingCategory = .tops
    @State private var color = ""
    @State private var pickedImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var isProcessing = false
    @State private var errorMsg: String?
    @State private var showImageSourcePicker = false
    @State private var showImagePicker = false
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dettagli Capo")) {
                    TextField("Nome capo", text: $name)
                        .textInputAutocapitalization(.words)
                    
                    Picker("Categoria", selection: $selectedCategory) {
                        ForEach(ClothingCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Colore", text: $color)
                        .textInputAutocapitalization(.words)
                }

                Section(header: Text("Immagine")) {
                    // Anteprima immagine con stato
                    ZStack {
                        if let img = processedImage {
                            // Immagine processata con successo
                            VStack(spacing: 12) {
                                ZStack {
                                    Color(.systemGray6)
                                        .cornerRadius(12)
                                    
                                    Image(uiImage: img)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 250)
                                }
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.caption)
                                    Text("Sfondo rimosso")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                            
                        } else if isProcessing {
                            // Animazione durante il processing
                            VStack(spacing: 20) {
                                ZStack {
                                    if let img = pickedImage {
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: 250)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.black.opacity(0.2))
                                            )
                                    }
                                }
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                
                                VStack(spacing: 12) {
                                    // Animazione scanner
                                    ScanningAnimation()
                                    
                                    Text("Elaborazione...")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 8)
                            
                        } else if let img = pickedImage {
                            // Immagine caricata ma non ancora processata (non dovrebbe succedere)
                            ZStack {
                                Color(.systemGray6)
                                    .cornerRadius(12)
                                
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 250)
                            }
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                            
                        } else {
                            // Stato vuoto - bottoni per caricare
                            VStack(spacing: 16) {
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                
                                Text("Aggiungi foto")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                HStack(spacing: 12) {
                                    Button(action: {
                                        print("AddClothingView: Bottone SCATTA premuto")
                                        print("AddClothingView: Impostando imageSourceType a .camera")
                                        imageSourceType = .camera
                                        print("AddClothingView: imageSourceType ora è:", imageSourceType == .camera ? "camera" : "photoLibrary")
                                        showImagePicker = true
                                        print("AddClothingView: showImagePicker impostato a true")
                                    }) {
                                        HStack(spacing: 6) {
                                            Image(systemName: "camera")
                                                .font(.system(size: 16))
                                            Text("Scatta")
                                                .font(.subheadline)
                                        }
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    }
                                    
                                    Button(action: {
                                        print("AddClothingView: Bottone GALLERIA premuto")
                                        imageSourceType = .photoLibrary
                                        showImagePicker = true
                                    }) {
                                        HStack(spacing: 6) {
                                            Image(systemName: "photo")
                                                .font(.system(size: 16))
                                            Text("Galleria")
                                                .font(.subheadline)
                                        }
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    // Messaggio di errore
                    if let errorMsg = errorMsg {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .font(.caption)
                            Text(errorMsg)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                    
                    // Bottone per cambiare immagine (sempre visibile se c'è un'immagine)
                    if pickedImage != nil {
                        Button(action: {
                            showImageSourcePicker = true
                        }) {
                            HStack {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.subheadline)
                                Text("Cambia foto")
                                    .font(.subheadline)
                            }
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Nuovo Capo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annulla") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salva") { saveClothingItem() }
                        .disabled(!canSave)
                        .fontWeight(.semibold)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $pickedImage, sourceType: imageSourceType)
                    .onAppear {
                        print("AddClothingView: Sheet aperto con sourceType:", imageSourceType == .camera ? "camera" : "photoLibrary")
                    }
            }
            .confirmationDialog("Scegli sorgente", isPresented: $showImageSourcePicker) {
                Button("Scatta foto") {
                    pickedImage = nil
                    processedImage = nil
                    errorMsg = nil
                    imageSourceType = .camera
                    showImagePicker = true
                }
                Button("Scegli dalla galleria") {
                    pickedImage = nil
                    processedImage = nil
                    errorMsg = nil
                    imageSourceType = .photoLibrary
                    showImagePicker = true
                }
                Button("Annulla", role: .cancel) { }
            }
            .onChange(of: pickedImage) { oldValue, newValue in
                if let newImage = newValue {
                    processImage(newImage)
                }
            }
        }
    }
    
    // Computed property per validare il form
    private var canSave: Bool {
        return !name.isEmpty && processedImage != nil && !isProcessing
    }
    
    // Funzione per processare automaticamente l'immagine
    private func processImage(_ image: UIImage) {
        print("AddClothingView: Inizio processing automatico")
        isProcessing = true
        errorMsg = nil
        processedImage = nil
        
        BackgroundRemover.removeBackground(from: image) { result in
            print("AddClothingView: callback da remover arrivata")
            isProcessing = false
            switch result {
            case .success(let imgNoBg):
                print("AddClothingView: Rimozione OK")
                processedImage = imgNoBg
            case .failure(let error):
                print("AddClothingView: Rimozione FALLITA", error.localizedDescription)
                processedImage = nil
                errorMsg = "Errore durante la rimozione dello sfondo. Riprova con un'altra foto."
            }
        }
    }

    private func saveClothingItem() {
        print("AddClothingView: Salvataggio premuto")
        guard let finalImage = processedImage else { return }
        let imageData = finalImage.jpegData(compressionQuality: 0.8)
        let newItem = ClothingItem(
            name: name,
            category: selectedCategory,
            color: color,
            imageData: imageData
        )
        viewModel.addClothingItem(newItem)
        dismiss()
    }
}

// MARK: - Componente Animazione Scanner
struct ScanningAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Cerchio di sfondo
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 2)
                .frame(width: 60, height: 60)
            
            // Icona scanner
            Image(systemName: "waveform")
                .font(.system(size: 28))
                .foregroundColor(.gray)
                .symbolEffect(.pulse, options: .repeating, value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

