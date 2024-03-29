//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitReportsView: View {
    @EnvironmentObject var visitReportsStore: VisitReportsViewModel
    
    var body: some View {
        CustomBackground {
            if visitReportsStore.isLoading {
                CustomLoading()
            } else {
                Logo()
                if(visitReportsStore.reports.isEmpty){
                    Text("noVisitsYet")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                    List(visitReportsStore.reports) { report in
                        NavigationLink(destination: VisitReportView(report: report)) {
                            CustomText(label: "property", value: report.estateValue?.address)
                        }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await visitReportsStore.load()
            }
        }
    }
}

struct VisitReportsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{VisitReportsView().environmentObject(VisitReportsViewModel.example())}
    }
}
