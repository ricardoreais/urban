//
//  BuyerHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BuyerHomeView: View {
    @ObservedObject var visitReportsStore: VisitReportsViewModel = VisitReportsViewModel.shared
    
    var body: some View {
        CustomTab {
            VisitReportsView()
            .tabItem {
                Label("myVisits", systemImage: "list.bullet")
            }
            VisitsCalendarView()
            .tabItem {
                Label("calendar", systemImage: "calendar")
            }
        }.environmentObject(visitReportsStore)
    }
}

struct BuyerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerHomeView(visitReportsStore: VisitReportsViewModel.example())
    }
}
