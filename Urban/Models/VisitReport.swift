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
    var clientName: String = ""
    var listingCode: String = ""
    var location: String = ""
    var listedValue: String = ""
    var address: String = ""
    var district: String = ""
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
    var userId: String = ""
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
}
