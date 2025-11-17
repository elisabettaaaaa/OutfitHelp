//
//  OutfitsPlaceholderView.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  OutfitsPlaceholderView.swift
//  VirtualWardrobe
//
//  Vista placeholder per la sezione Outfits
//

import SwiftUI

struct OutfitsPlaceholderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("👔")
                .font(.system(size: 48))
            Text("Outfits")
                .font(.system(size: 18, weight: .medium))
            Text("Funzionalità in arrivo")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
