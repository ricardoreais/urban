//
//  SellerHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct SellerHomeView: View {
    var body: some View {
        CustomTab {
            SellerEstatesView()
            .tabItem {
                Label("myEstates", systemImage: "list.bullet")
            }
            CustomBackground {
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .tabItem {
                Label("calendar", systemImage: "calendar")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SellerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SellerHomeView().environmentObject(UserManager.example())
    }
}
