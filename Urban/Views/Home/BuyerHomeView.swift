//
//  BuyerHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BuyerHomeView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
                .tabItem {
                    Label("createEstate", systemImage: "square.grid.3x1.folder.badge.plus")
                }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
                .tabItem {
                    Label("calendar", systemImage: "calendar")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BuyerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerHomeView()
    }
}
