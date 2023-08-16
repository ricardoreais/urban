//
//  BuyerHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BuyerHomeView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            VisitsView()
            .tabItem {
                Label("myVisits", systemImage: "list.bullet")
            }
            VisitsCalendarView()
            .tabItem {
                Label("calendar", systemImage: "calendar")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BuyerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerHomeView()
    }
}
