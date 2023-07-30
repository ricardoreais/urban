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
  
    func create(command: CreateUserCommand) -> Bool {
        return true
    }
}
