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
    var buyerValue: User?
    var estate: DocumentReference?
    var status: BidStatus
    
    static func Example() -> Bid{
        return Bid(
            id: "123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            value: 220000,
            buyer: User.ExampleReference(),
            buyerValue: User.BuyerExample(),
            estate: Estate.ExampleReference(),
            status: .draft)
    }
}
