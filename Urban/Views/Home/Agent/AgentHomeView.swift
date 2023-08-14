//
//  AgentHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI
import FirebaseFirestore

struct AgentHomeView: View {
    @EnvironmentObject var userObs: UserObservable
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            EstatesView(estateObs: EstateObservable(user: userObs))
            .tabItem {
                Label("estates", systemImage: "building.2")
            }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
                Text("Features: nome do comprador, opção de criar relatório de visita, opção de criar proposta")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
                .tabItem {
                    Label("buyers", systemImage: "person.3.sequence")
                }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("addBuyer", systemImage: "person.badge.plus")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct AgentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserObservable()
        user.isLoading = false
        user.value = User(
            id: "user123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "John Doe",
            email: "john@example.com",
            telephone: "123-456-7890",
            types: [.seller, .buyer]
        )
        return AgentHomeView()
            .environmentObject(user)
    }
}
