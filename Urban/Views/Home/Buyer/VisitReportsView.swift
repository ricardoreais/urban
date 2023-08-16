//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitReportsView: View {
    @ObservedObject var model: VisitReportsViewModel
    
    init(model: VisitReportsViewModel = .shared) {
        self.model = model
    }
    
    var body: some View {
        NavigationStack {
            CustomBackground {
                if model.isLoading {
                    CustomLoading()
                } else {
                    if(model.reports.isEmpty){
                        Text("noVisitsYet")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else {
                        List(model.reports) { report in
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
        let model = VisitReportsViewModel.shared
        model.isLoading = false
        model.reports = [
        ]
        return VisitReportsView(model: model)
    }
}
