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
import Combine

class EstateService {
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.estates)
    private let userService: UserService = UserService.shared
    static let shared = EstateService()
    private init(){}
    
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
        
        let estate = Estate(code: command.code, address: command.address, seller: seller, agents: command.agents)
        
        do {
            _ = try collection.addDocument(from: estate)
            Logger.infoCreatedEstate(estate.code)
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    func getByAgent(uuid: String) async -> [Estate] {
        do {
            let currentUserReference = userService.convertToDocumentReference(uuid)
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
    
    func getBySeller(uuid: String) async -> [Estate] {
        do {
            let currentUserReference = userService.convertToDocumentReference(uuid)
            let documents = try await collection.whereField("seller", isEqualTo: currentUserReference).getDocuments().documents
            
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
    
    func get(_ estateReference: DocumentReference) async -> Estate? {
        do {
            let document = try await estateReference.getDocument()
            let estateDocument = try document.data(as: Estate.self)
            return estateDocument
        } catch {
            // Handle any errors that occur during the Firestore query or decoding
            Logger.error(error)
            return nil
        }
    }
}
