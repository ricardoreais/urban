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
        NavigationStack {
            VStack(alignment: .leading) {
                Text("myVisits")
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
                    if(viewModel.reports.isEmpty){
                        Text("noVisitsYet")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else{
                        List(viewModel.reports) { report in
                            NavigationLink(destination: VisitDetailsView(id: report.id ?? "")) {
                                CustomTextView(label: "clientName", value: report.clientName) +
                                CustomTextView(label: "code", value: report.listingCode)
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
        let viewModel = VisitsViewModel()
        viewModel.reports = [
            VisitReport(id: "uN8uNes0lGhdpGHmFq2t", clientName: "John Doe", listingCode: "ABC123", location: "City", listedValue: "100000", userId: "6JAQAHYtNreSRJfEM9ssEr92uYx1")
        ]
        return VisitsView(viewModel: viewModel)
    }
}
