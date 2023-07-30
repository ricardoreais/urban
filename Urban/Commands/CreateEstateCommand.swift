//
//  CreateEstateCommand.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import Foundation
import FirebaseFirestore

struct CreateEstateCommand {
    var code: String
    var address: String
    var agents: [DocumentReference]
    var sellerEmail: String
}
