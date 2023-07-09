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
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var updatedAt: Date?
    var code: String = ""
    var address: String = ""
    var visits: [DocumentReference]?
    var bids: [DocumentReference]?
    var seller: DocumentReference?
    var agents: [DocumentReference]?
}
