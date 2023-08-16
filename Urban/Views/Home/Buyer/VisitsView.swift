//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitsView: View {
    @ObservedObject var viewModel = VisitReportsObservable()
    
    var body: some View {
        NavigationStack {
            CustomBackground {
                if viewModel.isLoading {
                    CustomLoading()
                } else {
                    if(viewModel.reports.isEmpty){
                        Text("noVisitsYet")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else {
                        List(viewModel.reports) { report in
                            NavigationLink(destination: VisitDetailsView(id: report.id ?? "")) {
                                CustomText(label: "clientName", value: "TODO")
                            }
                            .listRowBackground(ColorPalette.highlights)
                        }
                    }
                }
            }
            .background(ColorPalette.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .scrollContentBackground(.hidden)
        .foregroundColor(ColorPalette.secondary)
        .onAppear(perform: {
            viewModel.fetchVisitReports()
        })
    }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VisitReportsObservable()
        viewModel.isLoading = false
        viewModel.reports = [
        ]
        return VisitsView(viewModel: viewModel)
    }
}
