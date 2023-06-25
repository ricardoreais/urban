//
//  Evaluation.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import Foundation
enum Evaluation: String, Codable {
    case bad
    case medium
    case good
    case veryGood
    
    var rawValue: String {
        switch self {
        case .bad:
            return "Mau"
        case .medium:
            return "Médio"
        case .good:
            return "Bom"
        case .veryGood:
            return "Muito bom"
        }
    }
}
