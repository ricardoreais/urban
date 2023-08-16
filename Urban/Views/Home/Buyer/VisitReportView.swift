//
//  VisitDetailsView.swift
//  Urban
//
//  Created by Juliana Estrela on 25/06/2023.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VisitReportView: View {
    let report: VisitReport
    
    init(report: VisitReport) {
        self.report = report
    }

    var body: some View {
        CustomBackground(alignment: .leading) {
            Group {
                CustomText(label: "floorPlan", value: report.floorPlan.rawValue)
                CustomText(label: "finishes", value: report.finishes.rawValue)
                CustomText(label: "sunExposure", value: report.sunExposition.rawValue)
            }
            Group {
                CustomText(label: "location", value: report.locationRating.rawValue)
                CustomText(label: "value", value: report.value.rawValue)
                CustomText(label: "overallAssessment", value: report.overallAssessment.rawValue)
                CustomText(label: "kwService", value: report.agentService.rawValue)
                CustomText(label: "whatILiked", value: report.likes)
                CustomText(label: "whatIDisliked", value: report.dislikes)
                CustomText(label: "howMuchAmIWillingToPay", value: report.willingToPay)
                CustomText(label: "isItAnOption", value: report.isOption.rawValue)
                CustomText(label: "comments", value: report.comments)
            }
        }
    }
}

struct VisitReportView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportView(report: VisitReportServiceMock().visitReport)
    }
}
