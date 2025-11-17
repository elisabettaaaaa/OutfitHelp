//
//  EmptyStateView.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  EmptyStateView.swift
//  VirtualWardrobe
//
//  Vista mostrata quando l'armadio è vuoto
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("👕")
                .font(.system(size: 48))
            
            Text("Nessun capo nell'armadio")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.primary)
            
            Text("Premi il pulsante + per aggiungere i tuoi vestiti")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
