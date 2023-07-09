//
//  User.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Date?
    @ServerTimestamp var updatedAt: Date?
    var name: String?
    var email: String?
    var telephone: String?
    var types: [UserType]?
}
