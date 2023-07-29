//
//  UserCommandHandler.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class CreateUserCommandHandler: CommandHandler {
    func handle(command: CreateUserCommand) -> Bool {
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
}
