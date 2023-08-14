//
//  AgentHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import FirebaseFirestore
import SwiftUI

struct AgentHomeView: View {
    @ObservedObject private var userObs: UserObservable = UserObservable.shared
    @ObservedObject private var estateObs: EstateObservable = EstateObservable(user: UserObservable.shared)

    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            EstatesView(estateObs: estateObs, visitObs: VisitObservable(user: userObs, estateObs: estateObs))
                .tabItem {
                    Label("estates", systemImage: "building.2")
                }
            VStack {
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
            VStack {
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("addBuyer", systemImage: "person.badge.plus")
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct AgentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserObservable.shared
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
