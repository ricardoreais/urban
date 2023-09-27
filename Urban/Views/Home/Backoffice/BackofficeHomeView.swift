//
//  BackOfficeHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BackofficeHomeView: View {
    var body: some View {
        CustomTab {
            CreateEstateView()
            .tabItem {
                Label("createEstate", systemImage: "square.grid.3x1.folder.badge.plus")
            }
            CustomBackground {
                Logo()
                Text("comingSoon")
            }
            .tabItem {
                Label("updateUser", systemImage: "person.badge.shield.checkmark")
            }
            AddUserView()
            .tabItem {
                Label("createUser", systemImage: "person.badge.plus")
            }
            DeleteUserView()
            .tabItem {
                Label("deleteUser", systemImage: "person.badge.minus")
            }
        }
    }
}

struct BackofficeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BackofficeHomeView().environmentObject(UserManager.example())
    }
}
