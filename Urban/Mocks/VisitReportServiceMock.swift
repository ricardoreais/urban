//
//  VisitReportServiceMock.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisitReportServiceMock: VisitReportServiceProtocol {
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
    
    func get(id: String, completion: @escaping (Result<VisitReport, Error>) -> Void) {
        return completion(.success(visitReport))
    }
    
    func get() async throws -> [VisitReport] {
        return [visitReport]
    }
    
    func save(visitReport: VisitReport) async throws {
    }
}
