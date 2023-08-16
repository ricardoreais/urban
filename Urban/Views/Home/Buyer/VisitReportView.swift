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
        let visitReport = VisitReport(
            id: "someUniqueId",
            date: Timestamp(date: Date()),  // Replace with the actual date
            floorPlan: .medium,
            finishes: .medium,
            sunExposition: .medium,
            locationRating: .medium,
            value: .medium,
            overallAssessment: .medium,
            agentService: .medium,
            likes: "Likes about the property",
            dislikes: "Dislikes about the property",
            willingToPay: "Some amount",
            isOption: .yes,
            hasPropertyToSell: true,
            comments: "Additional comments",
            createdBy: Firestore.firestore().document("users/userId"),  // Replace with the actual user reference
            estate: Firestore.firestore().document("estates/estateId"),  // Replace with the actual estate reference
            buyer: Firestore.firestore().document("buyers/buyerId"),  // Replace with the actual buyer reference
            agent: Firestore.firestore().document("agents/agentId"),  // Replace with the actual agent reference
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date())
        )
        
        return VisitReportView(report: visitReport)
    }
}
