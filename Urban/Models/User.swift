//
//  User.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    @ServerTimestamp var updatedAt: Timestamp?
    var name: String?
    var email: String?
    var telephone: String?
    var types: [UserType]?
    
    static func ExampleReference() -> DocumentReference {
        return Firestore.firestore().document("users/userId")
    }
    static func AdminExample() -> User {
        return User(
            id: "user123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "John Doe",
            email: "john@example.com",
            telephone: "123-456-7890",
            types: [ .backoffice ]
        )
    }
    static func BuyerExample() -> User {
        return User(
            id: "buyer123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "Alice Buyer",
            email: "alice@example.com",
            telephone: "987-654-3210",
            types: [.buyer]
        )
    }
    static func SellerExample() -> User {
        return User(
            id: "seller123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "Bob Seller",
            email: "bob@example.com",
            telephone: "555-555-5555",
            types: [.seller]
        )
    }
    static func AgentExample() -> User {
        return User(
            id: "agent123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "Agent Smith",
            email: "agent@example.com",
            telephone: "555-123-4567",
            types: [.agent]
        )
    }
    static func GuestExample() -> User {
        return User(
            id: "guest123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "Guest User",
            email: "guest@example.com",
            telephone: "N/A", // Set as appropriate for guests
            types: [.guest]
        )
    }
}
