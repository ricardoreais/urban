//
//  VisitsView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI

struct VisitsView: View {
    @ObservedObject var viewModel = VisitsViewModel()
        
        var body: some View {
            NavigationView {
                List(viewModel.reports) { report in
                    Text("Cliente: \(report.clientName), Id: \(report.listingCode)")
                }.navigationTitle("As minhas visitas")
            }
            .onAppear {
                viewModel.fetchVisitReports()
            }
        }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsView()
    }
}
