//
//  UserService.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class UserService {
    static let shared = UserService()
    private init(){}
    
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.users)
    
    func convertToDocumentReference(_ userId: String) -> DocumentReference {
        return collection.document(userId)
    }
    
    func signIn(_ email: String, _ password: String) async -> (loggedIn: Bool, hasErrors: Bool) {
        var loggedIn = false
        var hasErrors = email.isEmpty || password.isEmpty
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            Logger.verboseSignIn(authResult.user.email ?? "")
            loggedIn = true
        } catch {
            print("Error during sign-in: \(error)")
            Logger.errorSignIn(error)
            hasErrors = true
        }
        
        return (loggedIn, hasErrors)
    }
    
    func get(email: String) async -> User? {
        do {
            let querySnapshot = try await collection.whereField("email", isEqualTo: email).getDocuments()
            guard let document = querySnapshot.documents.first else {
                Logger.errorFetchingUsers()
                return nil
            }
            
            let user = try document.data(as: User.self)
            Logger.infoFetchedUser(email)
            return user
        } catch {
            Logger.error(error)
            return nil
        }
    }
    
    func getCurrent() async -> User? {
        guard let userEmail = Auth.auth().currentUser?.email else {
            Logger.errorNoAuthenticatedUser()
            return nil
        }
        
        return await get(email: userEmail)
    }
    
    func create(command: CreateUserCommand) async -> Bool {
        guard !command.email.isEmpty, !command.password.isEmpty, command.password == command.confirmPassword else {
            return false
        }
        
        do {
            let email = command.email
            _ = try await Auth.auth().createUser(withEmail: email, password: command.password)
            let user = User(email: email, types: command.types)
            _ = try collection.addDocument(from: user)
            Logger.infoCreatingUser(email)
            
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    func get(_ type: UserType? = nil) async throws -> [User] {
        var query: Query = collection
        
        if let userType = type {
            query = query.whereField("types", arrayContains: "\(userType)")
        }
        
        let users: [User] = try await query.getDocuments().documents.compactMap { document in
            do {
                let userDocument = try document.data(as: User.self)
                Logger.verboseFetchedUser(userDocument.email!)
                return userDocument
            } catch {
                Logger.errorFetchingUsers()
                Logger.error(error)
                return nil
            }
        }
        
        return users
    }
    
    func delete(uid: String) async throws {
        let userRef = collection.document(uid)
        
        do {
            try await userRef.delete()
            
            let auth = Auth.auth()
            if let currentUser = auth.currentUser {
                try await currentUser.delete()
            }
            
            Logger.infoUserDeleted(uid)
        } catch {
            Logger.errorDeletingUser(uid)
            Logger.error(error)
            throw error
        }
    }
    
    func getReference(email: String) async throws -> DocumentReference? {
        do {
            let querySnapshot = try await collection.whereField("email", isEqualTo: email).getDocuments()
            
            if let document = querySnapshot.documents.first {
                return document.reference
            }
        } catch {
            Logger.error(error)
        }
        
        return nil
    }
    
    func getOrCreate(email: String) async -> (reference: DocumentReference?, success: Bool) {
        do {
            if let documentReference = try await getReference(email: email) {
                Logger.verboseUserAlreadyExists(email)
                return (documentReference, true)
            } else {
                Logger.verboseUserDoesNotExist(email)
                Logger.infoCreatingUser(email)
                
                let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [.seller], telephone: "")
                let userCreated = await create(command: createUserCommand)
                
                if userCreated {
                    if let newDocumentReference = try await getReference(email: email) {
                        return (newDocumentReference, true)
                    } else {
                        Logger.errorFetchingOrCreatingUser(email)
                        return (nil, false)
                    }
                } else {
                    return (nil, false)
                }
            }
        } catch {
            Logger.error(error)
            return (nil, false)
        }
    }
    
    func getByReference(_ userReference: DocumentReference) async -> User? {
        do {
            let document = try await userReference.getDocument()
            let userDocument = try document.data(as: User.self)
            return userDocument
        } catch {
            // Handle any errors that occur during the Firestore query or decoding
            Logger.error(error)
            return nil
        }
    }
}
