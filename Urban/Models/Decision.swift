//
//  Decision.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import Foundation

enum Decision: String, Codable {
    case yes
    case no
    case maybe
    
    var rawValue: String {
        switch self {
        case .yes:
            return "yes"
        case .no:
            return "no"
        case .maybe:
            return "maybe"
        }
    }
}
