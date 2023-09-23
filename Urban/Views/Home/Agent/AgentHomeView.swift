//
//  AgentHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import FirebaseFirestore
import SwiftUI

struct AgentHomeView: View {
    @ObservedObject var estateManager: EstatesViewModel = .shared
    
    var body: some View {
        CustomTab {
            EstatesView()
                .tabItem {
                    Label("estates", systemImage: "building.2")
                }.environmentObject(estateManager)
            CustomBackground {
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
                Text("Features: nome do comprador, opção de criar relatório de visita, opção de criar proposta")
                    .foregroundColor(ColorPalette.secondary)
            }
            .tabItem {
                Label("buyers", systemImage: "person.3.sequence")
            }
            CustomBackground {
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .tabItem {
                Label("addBuyer", systemImage: "person.badge.plus")
            }
        }
    }
}

struct AgentHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AgentHomeView(estateManager: EstatesViewModel.example())
    }
}
