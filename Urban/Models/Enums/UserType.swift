//
//  Scope.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import Foundation
import SwiftUI

enum UserType: String, Codable, LocalizedEnum {
    case guest
    case buyer
    case seller
    case agent
    case backoffice
    case admin
    
    var rawValue: LocalizedStringKey {
        switch self {
        case .guest:
            return "guest"
        case .buyer:
            return "buyer"
        case .seller:
            return "seller"
        case .agent:
            return "agent"
        case .backoffice:
            return "backoffice"
        case .admin:
            return "admin"
        }
    }
}
