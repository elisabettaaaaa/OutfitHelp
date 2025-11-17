//
//  TabButton..swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  TabButton.swift
//  VirtualWardrobe
//
//  Componente per un singolo pulsante della tab bar
//

import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if isSelected {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 2)
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                }
            }
        }
    }
}
