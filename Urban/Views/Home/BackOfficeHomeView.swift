//
//  BackOfficeHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BackofficeHomeView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
                
                Form
                {
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
                .tabItem {
                    Label("estates", systemImage: "building.2")
                }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("deleteUser", systemImage: "person.badge.minus")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BackofficeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BackofficeHomeView()
    }
}
