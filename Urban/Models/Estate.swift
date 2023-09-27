//
//  Estate.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Estate: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var code: String = ""
    var address: String = ""
    var seller: DocumentReference?
    var agents: [DocumentReference]?
    
    static func Example() -> Estate{
        return Estate(
            id: "123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            code: "E001",
            address: "Rampa das necessidades 3, Ajuda, Lisboa",
            seller: User.ExampleReference(),
            agents: [User.ExampleReference()])
    }
    
    static func ExampleReference() -> DocumentReference {
        return Firestore.firestore().document("Estate/estateId")
    }
}
