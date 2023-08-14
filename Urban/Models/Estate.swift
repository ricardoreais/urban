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
    var visits: [DocumentReference]?
    var bids: [DocumentReference]?
}
