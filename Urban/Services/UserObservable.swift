//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

// TODO: Refactor the observable and add consistency between logs and error validation etc... Maybe even isolate all the logs in a separate class
// Check if we should be using async await and clean these errors/warnings.
// Ident/format all files using the extension
// Only list agents in select list
class UserObservable: ObservableObject {
    @Published var value: User = .init()
    @Published var isLoading = true
    @Published var users: [User] = []
    private let collection: CollectionReference
    
    init() {
        collection = Firestore.firestore().collection(Collection.users)
    }
    
    func convertToDocumentReference(userId: String) -> DocumentReference {
        return collection.document(userId)
    }
    
    func getCurrent() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            Logger.errorNoAuthenticatedUser()
            return
        }
        
        collection
            .whereField("email", isEqualTo: userEmail)
            .getDocuments { snapshot, error in
                if let error = error {
                    Logger.error(error)
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    Logger.errorFetchingUser(userEmail)
                    return
                }
                
                let users: [User] = documents.compactMap { document -> User? in
                    do {
                        let userDocument = try document.data(as: User.self)
                        Logger.infoFetchedUser(userEmail)
                        return userDocument
                    } catch {
                        Logger.error(error)
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.value = users.first!
                }
            }
    }
    
    func create(command: CreateUserCommand) -> Bool {
        guard !command.email.isEmpty, !command.password.isEmpty, command.password == command.confirmPassword else {
            return false
        }
        
        let email = command.email
        Auth.auth().createUser(withEmail: email, password: command.password) { authResult, error in
            if let error = error {
                Logger.error(error)
                return
            }
            
            Logger.infoCreatingUser(email)
        }
        
        do {
            let user = User(email: command.email, types: command.types)
            _ = try collection.addDocument(from: user) { error in
                if let error = error {
                    Logger.error(error)
                } else {
                    Logger.infoCreatingUser(email)
                }
            }
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    func get(type: UserType? = nil) {
        var query: Query = collection
        
        if let userType = type {
            query = query.whereField("types", arrayContains: "\(userType)")
        }
        
        query.getDocuments { snapshot, error in
            if let error = error {
                Logger.error(error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                Logger.errorFetchingUsers()
                return
            }
            
            let users: [User] = documents.compactMap { document -> User? in
                do {
                    let userDocument = try document.data(as: User.self)
                    Logger.verboseFetchedUser(userDocument.email!)
                    return userDocument
                } catch {
                    Logger.error(error)
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
        let userRef = collection.document(uid)
        
        userRef.delete { error in
            if let error = error {
                Logger.errorDeletingUser(uid)
                Logger.error(error)
                completion(error)
                return
            }
            
            let auth = Auth.auth()
            auth.currentUser?.delete { error in
                Logger.errorDeletingUser(uid)
                Logger.error(error!)
                completion(error)
            }
            Logger.infoUserDeleted(uid)
        }
    }
    
    func get(email: String, completion: @escaping (DocumentReference?) -> Void) {
        collection.whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            if let error = error {
                Logger.error(error)
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
        get(email: email) { documentReference in
            if let documentRef = documentReference {
                Logger.verboseUserAlreadyExists(email)
                completion(documentRef, true)
            } else {
                Logger.verboseUserDoesNotExist(email)
                Logger.infoCreatingUser(email)
                let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [.seller], telephone: "")
                let userCreated = self.create(command: createUserCommand)
                
                if userCreated {
                    self.getOrCreate(email: email) { newDocumentReference, _ in
                        completion(newDocumentReference, true)
                    }
                } else {
                    completion(nil, false)
                }
            }
        }
    }
}
