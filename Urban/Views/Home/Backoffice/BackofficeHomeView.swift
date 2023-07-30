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
            CreateEstateView()
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
                Label("updateUser", systemImage: "person.badge.shield.checkmark")
            }
            VStack{
                AddUserView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("createUser", systemImage: "person.badge.plus")
            }
            VStack{
                DeleteUserView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("deleteUser", systemImage: "person.badge.minus")
            }
        }
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

struct BackofficeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BackofficeHomeView()
    }
}
