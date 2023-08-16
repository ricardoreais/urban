//
//  EstateService.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Firebase
import FirebaseFirestore
import Foundation
import SwiftUI


protocol EstateServiceProtocol {
    func convertToDocumentReference(_ estateId: String) -> DocumentReference
    func create(command: CreateEstateCommand) async -> Bool
    func get() async -> [Estate]
}

class EstateService: EstateServiceProtocol {
    private let collection: CollectionReference
    private let userService: UserService
    private let userManager: UserManager
    
    init(userManager: UserManager = .shared, userService: UserService = UserService()) {
        self.collection = Firestore.firestore().collection(Collection.estates)
        self.userService = userService
        self.userManager = userManager
    }
    
    func convertToDocumentReference(_ estateId: String) -> DocumentReference {
        return collection.document(estateId)
    }
    
    func create(command: CreateEstateCommand) async -> Bool {
        guard !command.code.isEmpty, !command.address.isEmpty,
              !command.sellerEmail.isEmpty, !command.agents.isEmpty
        else {
            Logger.errorCreatingEstate(command.code)
            return false
        }
        
        let result = await userService.getOrCreate(email: command.sellerEmail)
        
        guard let seller = result.reference else {
            Logger.errorFetchingOrCreatingUser(command.sellerEmail)
            return false
        }
        
        let estate = Estate(code: command.code, address: command.address, seller: seller, agents: command.agents, visits: [], bids: [])
        
        do {
            _ = try collection.addDocument(from: estate)
            Logger.infoCreatedEstate(estate.code)
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    func get() async -> [Estate] {
        do {
            let currentUserReference = userService.convertToDocumentReference(userManager.current.id!)
            let documents = try await collection.whereField("agents", arrayContains: currentUserReference).getDocuments().documents
            
            let estates: [Estate] = documents.compactMap { document -> Estate? in
                do {
                    let estateDocument = try document.data(as: Estate.self)
                    return estateDocument
                } catch {
                    Logger.error(error)
                    return nil
                }
            }
            
            Logger.verboseFetchedEstates()
            return estates
        } catch {
            Logger.error(error)
            return []
        }
    }
}
