//
//  EstateObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class EstateObservable: ObservableObject {
    @Published var values: [Estate] = []
    @Published var isLoading = true
    @Published var user = UserObservable()
    let collection = Firestore.firestore().collection(Collection.estates)
    
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
}

