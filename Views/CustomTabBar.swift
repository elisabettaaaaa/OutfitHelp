//
//  CustomTabBar.swift
//  outfit creation
//
//  Created by Elisabetta Garofalo on 08/11/25.
//

//
//  CustomTabBar.swift
//  VirtualWardrobe
//
//  Componente per la barra di navigazione personalizzata
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: WardrobeTab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 40) {
                ForEach(WardrobeTab.allCases, id: \.self) { tab in
                    TabButton(
                        title: tab.rawValue,
                        isSelected: selectedTab == tab
                    ) {
                        selectedTab = tab
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .background(Color.gray.opacity(0.3))
        }
    }
}
