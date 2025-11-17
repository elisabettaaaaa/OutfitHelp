//
//  AddButton.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  AddButton.swift
//  VirtualWardrobe
//
//  Componente per il pulsante flottante di aggiunta
//

import SwiftUI

struct AddButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.primary)
                    .frame(width: 60, height: 60)
                    .shadow(color: .black.opacity(0.15), radius: 12, y: 4)
                
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(Color(.systemBackground))
            }
        }
    }
}
