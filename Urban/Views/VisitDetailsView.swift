//
//  VisitDetailsView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI

struct VisitDetailsView: View {
    let id: String
    @ObservedObject var viewModel = VisitReportObservable()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Visita \(viewModel.report.listingCode)")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
            HStack(alignment: .top){
                VStack(alignment: .leading) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                            .scaleEffect(2)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Group {
                            Group {
                                CustomTextView(label: "clientName", value: viewModel.report.clientName).padding(.bottom, 1)
                                CustomTextView(label: "code", value: viewModel.report.listingCode)
                                CustomTextView(label: "location", value: viewModel.report.location)
                                CustomTextView(label: "value", value: "\(viewModel.report.listedValue)")
                                CustomTextView(label: "address", value: viewModel.report.address)
                                CustomTextView(label: "district", value: viewModel.report.district)
                                CustomTextView(label: "floorPlan", value: viewModel.report.floorPlan.rawValue)
                                CustomTextView(label: "finishes", value: viewModel.report.finishes.rawValue)
                                CustomTextView(label: "sunExposure", value: viewModel.report.sunExposition.rawValue)
                            }
                            Group {
                                CustomTextView(label: "location", value: viewModel.report.locationRating.rawValue)
                                CustomTextView(label: "value", value: viewModel.report.value.rawValue)
                                CustomTextView(label: "overallAssessment", value: viewModel.report.overallAssessment.rawValue)
                                CustomTextView(label: "kwService", value: viewModel.report.agentService.rawValue)
                                CustomTextView(label: "whatILiked", value: viewModel.report.likes)
                                CustomTextView(label: "whatIDisliked", value: viewModel.report.dislikes)
                                CustomTextView(label: "howMuchAmIWillingToPay", value: viewModel.report.willingToPay)
                                CustomTextView(label: "isItAnOption", value: viewModel.report.isOption.rawValue)
                                CustomTextView(label: "comments", value: viewModel.report.comments)
                            }
                        }.padding(1)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .foregroundColor(ColorPalette.secondary)
                .background(ColorPalette.primary)
            }
        }
        .padding(20)
        .onAppear(perform: {
            viewModel.fetchVisitReport(id: id)
        })
        .foregroundColor(ColorPalette.secondary)
        .background(ColorPalette.primary)
    }
}

struct VisitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VisitReportObservable()
        viewModel.report = VisitReport(id: "uN8uNes0lGhdpGHmFq2t", clientName: "John Doe", listingCode: "ABC123", location: "City", listedValue: "100000", willingToPay: "eaa", userId: "6JAQAHYtNreSRJfEM9ssEr92uYx1")
        viewModel.isLoading = false
        return VisitDetailsView(id: "6JAQAHYtNreSRJfEM9ssEr92uYx1", viewModel: viewModel)
    }
}
