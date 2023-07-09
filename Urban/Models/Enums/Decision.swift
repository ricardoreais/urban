//
//  Decision.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import Foundation
import SwiftUI

enum Decision: String, Codable, LocalizedEnum {
    case yes
    case no
    case maybe
    
    var rawValue: LocalizedStringKey {
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
