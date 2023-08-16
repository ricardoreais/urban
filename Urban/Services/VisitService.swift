//
//  VisitService.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Firebase
import FirebaseFirestore
import Foundation

class VisitService {
    private let collection: CollectionReference
    private let userService: UserService
    private let estateService: EstateService
    private let userManager: UserManager
    
    init(userService: UserService = UserService(), estateService: EstateService = EstateService(), userManager: UserManager = .shared) {
        self.collection = Firestore.firestore().collection(Collection.visits)
        self.estateService = estateService
        self.userService = userService
        self.userManager = userManager
    }
    
    func create(_ command: CreateVisitCommand) async -> Bool {
        let currentUserReference = userService.convertToDocumentReference(userManager.current.id!)
        let buyerReference = userService.convertToDocumentReference(command.buyer.id!)
        let currentEstate = estateService.convertToDocumentReference((command.estate.id)!)
        let visit = Visit(date: command.date, estate: currentEstate, buyer: buyerReference, agent: currentUserReference)
        
        do {
            _ = try collection.addDocument(from: visit)
            Logger.infoVisitCreated(command.date)
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    func get() async -> [Visit] {
        do {
            guard let currentUser = await userService.getCurrent() else {
                Logger.error("No current user found.")
                return []
            }
            
            let currentUserReference = userService.convertToDocumentReference(currentUser.id!)
            let documents = try await collection.whereField("buyer", isEqualTo: currentUserReference).getDocuments().documents
            
            let visits: [Visit] = documents.compactMap { document -> Visit? in
                do {
                    return try document.data(as: Visit.self)
                } catch {
                    Logger.error(error)
                    return nil
                }
            }
            
            return visits
        } catch {
            Logger.error(error)
            return []
        }
    }
}                                                       
