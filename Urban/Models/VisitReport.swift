//
//  VisitForm.swift
//  Urban
//
//  Created by Juliana Estrela on 15/04/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct VisitReport: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var date: Timestamp?
    var floorPlan: Evaluation = Evaluation.medium
    var finishes: Evaluation = Evaluation.medium
    var sunExposition: Evaluation = Evaluation.medium
    var locationRating: Evaluation = Evaluation.medium
    var value: Evaluation = Evaluation.medium
    var overallAssessment: Evaluation = Evaluation.medium
    var agentService: Evaluation = Evaluation.medium
    var likes: String = ""
    var dislikes: String = ""
    var willingToPay: String = ""
    var isOption: Decision = Decision.yes
    var hasPropertyToSell: Bool = false
    var comments: String = ""
    var createdBy: DocumentReference?
    var estate: DocumentReference?
    var buyer: DocumentReference?
    var agent: DocumentReference?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    
    static func Example() -> VisitReport{
        return VisitReport(
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
    }
}
