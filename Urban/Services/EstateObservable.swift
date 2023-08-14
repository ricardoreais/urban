//
//  EstateObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore

class EstateObservable: ObservableObject {
    @Published var values: [Estate] = []
    @Published var isLoading = true
    var user: UserObservable
    
    init(user: UserObservable){
        self.user = user
    }

    private let collection: CollectionReference = Firestore.firestore().collection(Collection.estates)
    
    func create(command: CreateEstateCommand) async -> Bool {
        guard !command.code.isEmpty, !command.address.isEmpty,
              !command.sellerEmail.isEmpty, !command.agents.isEmpty else {
            Logger.errorCreatingEstate(command.code)
            return false
        }
        
        let result = await user.getOrCreate(email: command.sellerEmail)
        
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
    
    func get() async -> Void {
        do {
            let currentUserReference = user.convertToDocumentReference(user.value.id!)
            let documents = try await collection.whereField("agents", arrayContains: currentUserReference).getDocuments().documents
            let estates: [Estate] = documents.compactMap { document -> Estate? in
                do {
                    let estateDocument = try document.data(as: Estate.self)
                    Logger.verboseFetchedEstates()
                    return estateDocument
                } catch {
                    Logger.error(error)
                    return nil
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.values = estates
            }
        } catch {
            Logger.error(error)
        }
        
    }
}

