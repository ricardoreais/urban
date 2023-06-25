//
//  SandboxView.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import SwiftUI

struct HomeView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            VisitsView()
                .tabItem {
                    Label("As minhas visitas", systemImage: "list.bullet")
                }
            VisitReportFormView()
                .tabItem {
                    Label("Criar visita", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
