//
//  VisitDetailsView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI

struct VisitDetailsView: View {
    let id: String
    @ObservedObject var viewModel = VisitReportObservable.shared

    var body: some View {
        VStack(alignment: .leading) {
            // TODO:
            Text("Visita \("viewModel.report.listingCode")")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 16)
            HStack(alignment: .top) {
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
                                CustomText(label: "floorPlan", value: viewModel.report.floorPlan.rawValue)
                                CustomText(label: "finishes", value: viewModel.report.finishes.rawValue)
                                CustomText(label: "sunExposure", value: viewModel.report.sunExposition.rawValue)
                            }
                            Group {
                                CustomText(label: "location", value: viewModel.report.locationRating.rawValue)
                                CustomText(label: "value", value: viewModel.report.value.rawValue)
                                CustomText(label: "overallAssessment", value: viewModel.report.overallAssessment.rawValue)
                                CustomText(label: "kwService", value: viewModel.report.agentService.rawValue)
                                CustomText(label: "whatILiked", value: viewModel.report.likes)
                                CustomText(label: "whatIDisliked", value: viewModel.report.dislikes)
                                CustomText(label: "howMuchAmIWillingToPay", value: viewModel.report.willingToPay)
                                CustomText(label: "isItAnOption", value: viewModel.report.isOption.rawValue)
                                CustomText(label: "comments", value: viewModel.report.comments)
                            }
                        }.padding(1)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
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
        let viewModel = VisitReportObservable.shared
        viewModel.isLoading = true
        return VisitDetailsView(id: "6JAQAHYtNreSRJfEM9ssEr92uYx1", viewModel: viewModel)
    }
}
