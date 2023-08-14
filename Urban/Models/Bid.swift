//
//  Bid.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Bid: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var value: Decimal?
    var buyer: DocumentReference?
}
