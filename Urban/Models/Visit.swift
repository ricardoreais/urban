//
//  Visit.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Visit: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var date: Date?
    var estate: DocumentReference?
    var reports: [DocumentReference]?
    var buyer: DocumentReference?
    var agent: DocumentReference?
}
