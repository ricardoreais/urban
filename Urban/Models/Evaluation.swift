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
            return "bad"
        case .medium:
            return "medium"
        case .good:
            return "good"
        case .veryGood:
            return "veryGood"
        }
    }
}
