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
                    Label("myVisits", systemImage: "list.bullet")
                }
            VisitReportFormView()
                .tabItem {
                    Label("createVisit", systemImage: "square.and.pencil")
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
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("myAccount", systemImage: "person")
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
