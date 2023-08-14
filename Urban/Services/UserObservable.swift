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

class UserObservable: ObservableObject {
    static let shared = UserObservable()
    private init() {}
    
    @Published var value: User = User()
    @Published var isLoading = true
    @Published var users: [User] = []
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.users)
    
    func signIn(_ email: String, _ password: String) async -> (loggedIn: Bool, hasErrors: Bool) {
        var loggedIn = false
        var hasErrors = email.isEmpty || password.isEmpty
        
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            Logger.verboseSignIn(authResult.user.email ?? "")
            loggedIn = true
        } catch {
            Logger.errorSignIn(error)
            hasErrors = true
        }
        
        return (loggedIn, hasErrors)
    }
    
    func convertToDocumentReference(_ userId: String) -> DocumentReference {
        return collection.document(userId)
    }
    
    func getCurrent() async -> Void {
        guard let userEmail = Auth.auth().currentUser?.email else {
            Logger.errorNoAuthenticatedUser()
            return
        }
        
        do {
            let documents = try await collection.whereField("email", isEqualTo: userEmail).getDocuments().documents
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
        } catch {
            Logger.error(error)
        }
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
    
    func get(email: String) async throws -> DocumentReference? {
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
            if let documentReference = try await get(email: email) {
                Logger.verboseUserAlreadyExists(email)
                return (documentReference, true)
            } else {
                Logger.verboseUserDoesNotExist(email)
                Logger.infoCreatingUser(email)
                
                let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [.seller], telephone: "")
                let userCreated = await create(command: createUserCommand)
                
                if userCreated {
                    if let newDocumentReference = try await get(email: email) {
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
}
