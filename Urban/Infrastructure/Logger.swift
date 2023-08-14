//
//  Logger.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import Foundation

class Logger {
    static func error(_ message: String) -> Void {
        print("Error: \(message)")
    }
    
    static func error(_ error: Error) -> Void {
        self.error(error.localizedDescription)
    }
    
    static func info(_ message: String) -> Void {
        print("Info: \(message)")
    }
    
    static func verbose(_ message: String) -> Void {
        print("Verbose: \(message)")
    }
    
    static func infoCreatingUser(_ email: String) -> Void {
        info("User created successfully with email: \(email)")
    }
    
    static func verboseFetchedUser(_ email: String) -> Void {
        verbose("User fetched successfully with email: \(email)")
    }
    
    static func verboseUserAlreadyExists(_ email: String) -> Void {
        verbose("User with email: \(email) already exists")
    }
    
    static func verboseUserDoesNotExist(_ email: String) -> Void {
        verbose("User with email: \(email) doesn't exist")
    }
    
    static func infoFetchedUser(_ email: String) -> Void {
        info("User fetched successfully with email: \(email)")
    }
    
    static func errorFetchingUsers() -> Void {
        error("No users found!")
    }
    
    static func errorFetchingUser(_ email: String?) -> Void {
        error("User with email: \(email!) not found!")
    }
    
    static func errorNoAuthenticatedUser() -> Void {
        error("No authenticated user found!")
    }
    
    static func infoUpdatingUser(_ email: String) -> Void {
        info("User updated successfully with email: \(email)")
    }
    
    static func infoUserDeleted(_ uid: String) -> Void {
        info("User deleted successfully with uid: \(uid)")
    }
    
    static func errorDeletingUser(_ uid: String) -> Void {
        error("Error deleting user with uid: \(uid)")
    }
    
    static func errorCreatingEstate(_ code: String) -> Void {
        error("Error creating estate with code: \(code)")
    }
    
    static func infoCreatedEstate(_ code: String) -> Void {
        info("Estate with code: \(code) created with success!")
    }
    
    static func errorFetchingOrCreatingUser(_ email: String) -> Void {
        error("Error fetching or creating user (seller) with email: \(email)")
    }
    
    static func verboseSignIn(_ email: String) -> Void {
        verbose("Sign in successfull")
    }
    
    static func errorSignIn(_ error: Error) -> Void {
        self.error("Sign in failed \(error.localizedDescription)")
    }
    
    static func verboseFetchedEstates() -> Void {
        verbose("Estates fetched with success!")
    }
}
