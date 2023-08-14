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
  
    func create(command: CreateEstateCommand) -> Bool {
        let hasErrors = command.code.isEmpty || command.address.isEmpty || command.sellerEmail.isEmpty || command.agents.isEmpty
        
        if(hasErrors){
            Logger.errorCreatingEstate(command.code)
            return false
        }
        
        user.getOrCreate(email: command.sellerEmail) { documentReference, userCreated in
            if let docRef = documentReference {
                do {
                    let estate = Estate(code: command.code,  address: command.address, seller: docRef, agents: command.agents, visits: [], bids: [])
                    _ = try self.collection.addDocument(from: estate) { error in
                        if let error = error {
                            Logger.error(error)
                            return
                        } else {
                            Logger.infoCreatedEstate(estate.code)
                        }
                    }
                } catch let error {
                    Logger.error(error)
                    return
                }
                return
                
            } else {
                Logger.errorFetchingOrCreatingUser(command.sellerEmail)
            }
        }
        
        return true
    }
}
