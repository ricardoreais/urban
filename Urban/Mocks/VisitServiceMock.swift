//
//  VisitServiceMock.swift
//  Urban
//
//  Created by Juliana Estrela on 17/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisitServiceMock: VisitServiceProtocol {
    let visit1 = Visit(
        id: "visit123",
        date: Date(),
        estate: UserServiceMock().reference,
        reports: [],
        buyer: UserServiceMock().reference,
        agent: UserServiceMock().reference
    )
    let visit2 = Visit(
        id: "visit456",
        date: Date(),
        estate: UserServiceMock().reference,
        reports: [],
        buyer: UserServiceMock().reference,
        agent: UserServiceMock().reference
    )
    
    func create(_ command: CreateVisitCommand) async -> Bool {
        return true
    }
    
    func get() async -> [Visit] {
        return [visit1, visit2]
    }
}
