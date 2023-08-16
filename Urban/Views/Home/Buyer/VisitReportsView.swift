//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitReportsView: View {
    @ObservedObject var visitReportsStore: VisitReportsViewModel
    
    init(visitReportsStore: VisitReportsViewModel) {
        self.visitReportsStore = visitReportsStore
    }
    
    var body: some View {
        NavigationStack {
            CustomBackground {
                if visitReportsStore.isLoading {
                    CustomLoading()
                } else {
                    if(visitReportsStore.reports.isEmpty){
                        Text("noVisitsYet")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else {
                        List(visitReportsStore.reports) { report in
                            NavigationLink(destination: VisitReportView(report: report)) {
                                CustomText(label: "clientName", value: "TODO")
                            }
                            .listRowBackground(ColorPalette.highlights)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .foregroundColor(ColorPalette.secondary)
    }
}

struct VisitReportsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportsView(visitReportsStore: VisitReportsViewModel(visitReportService: VisitReportServiceMock()))
    }
}
