//
//  EstateServiceProtocol.swift
//  Urban
//
//  Created by Juliana Estrela on 17/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class EstateServiceMock: EstateServiceProtocol {
    let estate1 = Estate(
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()), code: "E001", address: "123 Main St", seller: nil, agents: nil, visits: nil, bids: nil)
    let estate2 = Estate(
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()), code: "E002", address: "456 Elm St", seller: nil, agents: nil, visits: nil, bids: nil)
    let estate3 = Estate(
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()), code: "E003", address: "789 Oak St", seller: nil, agents: nil, visits: nil, bids: nil)
    
    func convertToDocumentReference(_ estateId: String) -> DocumentReference {
        return Firestore.firestore().document("estates/estateId")
    }
    
    func create(command: CreateEstateCommand) async -> Bool {
        return true
    }
    
    func get() async -> [Estate] {
        return [estate1, estate2, estate3]
    }
}
