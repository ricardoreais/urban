//
//  BuyerHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BuyerHomeView: View {
    @ObservedObject var visitReportsStore: VisitReportsViewModel
    
    init(visitReportsStore: VisitReportsViewModel = .shared) {
        self.visitReportsStore = visitReportsStore
    }
    
    var body: some View {
        CustomTab {
            VisitReportsView(visitReportsStore: visitReportsStore)
            .tabItem {
                Label("myVisits", systemImage: "list.bullet")
            }
            VisitsCalendarView()
            .tabItem {
                Label("calendar", systemImage: "calendar")
            }
        }
    }
}

struct BuyerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BuyerHomeView(visitReportsStore: VisitReportsViewModel(visitReportService: VisitReportServiceMock()))
    }
}