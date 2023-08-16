//
//  UserServiceMock.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserServiceMock: UserServiceProtocol {
    let admin = User(
        id: "user123",
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()),
        name: "John Doe",
        email: "john@example.com",
        telephone: "123-456-7890",
        types: [ .backoffice ]
    )
    let buyer = User(
        id: "buyer123",
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()),
        name: "Alice Buyer",
        email: "alice@example.com",
        telephone: "987-654-3210",
        types: [.buyer]
    )
    
    let seller = User(
        id: "seller123",
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()),
        name: "Bob Seller",
        email: "bob@example.com",
        telephone: "555-555-5555",
        types: [.seller]
    )
    let agent = User(
        id: "agent123",
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()),
        name: "Agent Smith",
        email: "agent@example.com",
        telephone: "555-123-4567",
        types: [.agent]
    )
    let guest = User(
        id: "guest123",
        createdAt: Timestamp(date: Date()),
        updatedAt: Timestamp(date: Date()),
        name: "Guest User",
        email: "guest@example.com",
        telephone: "N/A", // Set as appropriate for guests
        types: [.guest]
    )
    let reference =  Firestore.firestore().document("users/userId")
    
    func convertToDocumentReference(_ userId: String) -> DocumentReference {
        return reference
    }
    
    func signIn(_ email: String, _ password: String) async -> (loggedIn: Bool, hasErrors: Bool) {
        return (true, false)
    }
    
    func getCurrent() async -> User? {
        return admin
    }
    
    func create(command: CreateUserCommand) async -> Bool {
        return true
    }
    
    func get(_ type: UserType?) async throws -> [User] {
        
        return [buyer, seller, admin, guest, agent]
    }
    
    func delete(uid: String) async throws -> Void {
        return
    }
    
    func get(email: String) async throws -> DocumentReference? {
        return reference
    }
    
    func getOrCreate(email: String) async -> (reference: DocumentReference?, success: Bool) {
        return (reference, true)
    }
}
