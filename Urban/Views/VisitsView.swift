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
        VStack(alignment: .leading) {
            Text("As minhas visitas")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
                .padding(.leading, 20)
            
            if viewModel.isLoading {
               ProgressView()
                   .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                   .scaleEffect(2)
                   .padding()
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
           } else {
               List(viewModel.reports) { report in
                   Group {
                           Text("Cliente ")
                           .foregroundColor(.accentColor)
                           .fontWeight(.bold) +
                           Text(report.clientName) +
                           Text(" Código ")
                               .foregroundColor(.accentColor)
                               .fontWeight(.bold) +
                       Text(report.listingCode)
                   }.listRowBackground(ColorPalette.highlights)
               }
               .scrollContentBackground(.hidden)
           }
        }
        .foregroundColor(ColorPalette.secondary)
        .background(ColorPalette.primary)
        .onAppear(perform: {
            viewModel.fetchVisitReports()
        })
    }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VisitsViewModel()
        viewModel.reports = [
            VisitReport(id: "1", clientName: "John Doe", listingCode: "ABC123", location: "City", listedValue: 100000),
            VisitReport(id: "2", clientName: "Jane Smith", listingCode: "XYZ789", location: "Suburb", listedValue: 150000)
            // Add more mock data as needed
        ]
        return VisitsView(viewModel: viewModel)
    }
}
