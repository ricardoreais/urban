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
    let db = Firestore.firestore()
    let collectionRef = Firestore.firestore().collection("Estates")
  
    func create(command: CreateEstateCommand) -> Bool {
        let hasErrors = command.code.isEmpty || command.address.isEmpty || command.sellerEmail.isEmpty || command.agents.isEmpty
        
        if(hasErrors){
            print("Estate has errors")
            return false
        }
        
        print("Getting seller reference")
        user.getOrCreate(email: command.sellerEmail) { documentReference, userCreated in
            if let docRef = documentReference {
                print("User (seller) document reference: \(docRef.path)")
                do {
                    let estate = Estate(code: command.code,  address: command.address, seller: docRef, agents: command.agents, visits: [], bids: [])
                    try self.collectionRef.addDocument(from: estate) { error in
                        if let error = error {
                            print("Error saving data: \(error.localizedDescription)")
                            return
                        } else {
                            print("Estate \(estate.code) created with success!")
                        }
                    }
                } catch let error {
                    print("Error saving data: \(error)")
                    return
                }
                return
                
            } else {
                print("Failed to retrieve or create user (seller).")
            }
        }
        
        return true
    }
}
