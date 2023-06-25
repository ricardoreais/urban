//
//  VisitDetailsView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI

struct VisitDetailsView: View {
    let id: String
    @ObservedObject var viewModel = VisitViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Visita \(viewModel.report.listingCode)")
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
                VStack(alignment: .leading) {
                    Group {
                        CustomTextView(label: "Cliente ", value: viewModel.report.clientName)
                        CustomTextView(label: "Código ", value: viewModel.report.listingCode)
                        CustomTextView(label: "Location ", value: viewModel.report.location)
                        CustomTextView(label: "Listed Value ", value: "\(viewModel.report.listedValue)")
                        CustomTextView(label: "Address ", value: viewModel.report.address)
                        CustomTextView(label: "District ", value: viewModel.report.district)
                        CustomTextView(label: "Floor Plan ", value: viewModel.report.floorPlan.rawValue)
                        CustomTextView(label: "Finishes ", value: viewModel.report.finishes.rawValue)
                        CustomTextView(label: "Sun Exposition ", value: viewModel.report.sunExposition.rawValue)
                    }
                    Group {
                        CustomTextView(label: "Location Rating ", value: viewModel.report.locationRating.rawValue)
                        CustomTextView(label: "Value ", value: viewModel.report.value.rawValue)
                        CustomTextView(label: "Overall Assessment ", value: viewModel.report.overallAssessment.rawValue)
                        CustomTextView(label: "Agent Service ", value: viewModel.report.agentService.rawValue)
                        CustomTextView(label: "Likes ", value: viewModel.report.likes)
                        CustomTextView(label: "Dislikes ", value: viewModel.report.dislikes)
                        CustomTextView(label: "Willing to Pay ", value: viewModel.report.willingToPay)
                        CustomTextView(label: "Is Option ", value: viewModel.report.isOption.rawValue)
                        CustomTextView(label: "Has Property to Sell ", value: viewModel.report.hasPropertyToSell ? "Sim" : "Não")
                        CustomTextView(label: "Comments ", value: viewModel.report.comments)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
        }
        .foregroundColor(ColorPalette.secondary)
        .background(ColorPalette.primary)
        .onAppear(perform: {
            viewModel.fetchVisitReport(id: id)
        })
    }
}

struct VisitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitDetailsView(id: "uN8uNes0lGhdpGHmFq2t")
    }
}
