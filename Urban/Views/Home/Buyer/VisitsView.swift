//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitsView: View {
    @ObservedObject var model: VisitsViewModel
    
    init(model: VisitsViewModel = .shared) {
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
                            NavigationLink(destination: VisitDetailsView(report: report)) {
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

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        let model = VisitsViewModel.shared
        model.isLoading = false
        model.reports = [
        ]
        return VisitsView(model: model)
    }
}
