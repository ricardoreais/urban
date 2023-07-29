//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserObservable: ObservableObject {
    @Published var value: User = User()
    @Published var isLoading = true
    
    func fetch() {
        let db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            let userEmail = currentUser.email
            print("Current user email: \(userEmail)")
            
            db.collection("Users")
                .whereField("email", isEqualTo: userEmail)
                .getDocuments { snapshot, error in
                    if let error = error {
                        print("Error fetching visit reports: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let documents = snapshot?.documents else {
                        print("No documents found")
                        return
                    }
                    
                    let users: [User] = documents.compactMap { document -> User? in
                        do {
                            let userDocument = try document.data(as: User.self)
                            print("Obtained user \(userDocument.email) with success!")
                            return userDocument
                        } catch {
                            print("Error decoding document: \(error.localizedDescription)")
                            print(String(describing: error))
                            return nil
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        if let firstUser = users.first {
                            self.value = firstUser
                        } else {
                            print("No current user")
                        }
                    }
                } } else {
                    print("No current user")
                }
    }
}
