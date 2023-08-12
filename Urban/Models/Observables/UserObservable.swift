//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Firebase
import FirebaseFirestore
import Foundation

class UserObservable: ObservableObject {
    @Published var value: User = .init()
    @Published var isLoading = true
    @Published var users: [User] = []
    private var db = Firestore.firestore()
    
    func convertToDocumentReference(userId: String) -> DocumentReference {
        return db.collection("Users").document(userId)
    }
    
    func getCurrent() {
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
                }
        } else {
            print("No current user")
        }
    }
    
    func create(command: CreateUserCommand) -> Bool {
        let hasErrors = command.email.isEmpty || command.password.isEmpty || command.confirmPassword.isEmpty || command.password != command.confirmPassword
        
        if hasErrors {
            return false
        }
        
        Auth.auth().createUser(withEmail: command.email, password: command.password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print("Error creating user: \(error!.localizedDescription)")
                return
            }
            print("User created successfully with name: \(user.email ?? "")")
        }
        
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
        } catch {
            print("Error saving data: \(error)")
            return false
        }
        
        return true
    }
    
    func getAll() {
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
    
    func get(email: String, completion: @escaping (DocumentReference?) -> Void) {
        let usersCollection = db.collection("Users")
        
        usersCollection.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                completion(nil)
                return
            }
            
            if let document = querySnapshot?.documents.first {
                completion(document.reference)
            } else {
                completion(nil)
            }
        }
    }
    
    func getOrCreate(email: String, completion: @escaping (DocumentReference?, Bool) -> Void) {
        self.get(email: email) { documentReference in
            if let documentRef = documentReference {
                print("User exists. Document Reference: \(documentRef.path)")
                completion(documentRef, true)
            } else {
                print("User does not exist. Document not found. Creating new user...")
                let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [.seller], telephone: "")
                let userCreated = self.create(command: createUserCommand)
                
                if userCreated {
                    self.getOrCreate(email: email) { newDocumentReference, success in
                        completion(newDocumentReference, true)
                    }
                } else {
                    completion(nil, false)
                }
            }
        }
    }
}
