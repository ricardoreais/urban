//
//  CreateUserCommand.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation

struct CreateUserCommand {
    let name: String
    let password: String
    let confirmPassword: String
    let email: String
    let types: [UserType]
    let telephone: String
}	
