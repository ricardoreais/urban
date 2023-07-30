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
    @Published var users: [User] = []
    
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
    
    func create(command: CreateUserCommand) -> Bool {
        let hasErrors = command.email.isEmpty || command.password.isEmpty || command.confirmPassword.isEmpty || command.password != command.confirmPassword
        
        if(hasErrors){
            return false
        }
        
        Auth.auth().createUser(withEmail: command.email, password: command.password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error creating user: \(error!.localizedDescription)")
                return
            }
            print("User created successfully with name: \(user.email ?? "")")
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("Users")
        do {
            let user = User(email: command.email, types: command.types)
            try collectionRef.addDocument(from: user) { error in
                if let error = error {
                    print("Error saving data: \(error.localizedDescription)")
                    return
                } else {
                    print("User created with success!")
                }
            }
        } catch let error {
            print("Error saving data: \(error)")
            return false
        }
        
        return true
    }
    
    func getAll() {
        let db = Firestore.firestore()
            db.collection("Users")
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
                    self.users = users
                }
            }
    }
    
    func delete(uid: String, completion: @escaping (Error?) -> Void) {
        // First, delete the user document from Firestore
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(uid)
        
        userRef.delete { error in
            if let error = error {
                completion(error)
                return
            }
            
            // If the user document is deleted successfully, remove the user's authentication in Firebase
            let auth = Auth.auth()
            auth.currentUser?.delete { error in
                if let error = error {
                    completion(error)
                    return
                }
                
                // Both Firestore document and user authentication are successfully deleted
                completion(nil)
            }
        }
    }
}
