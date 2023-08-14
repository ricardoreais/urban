//
//  AgentHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import FirebaseFirestore
import SwiftUI

struct AgentHomeView: View {
    @ObservedObject private var userObs: UserObservable = .shared
    @ObservedObject private var estateObs: EstateObservable = .shared

    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            EstatesView()
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
        AgentHomeView()
    }
}
