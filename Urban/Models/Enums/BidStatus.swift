//
//  BidStatus.swift
//  Urban
//
//  Created by Juliana Estrela on 13/02/2024.
//

import Foundation
import SwiftUI

enum BidStatus: String, Codable, LocalizedEnum {
    case draft
    case finished
    
    var rawValue: LocalizedStringKey {
        switch self {
        case .draft:
            return "draft"
        case .finished:
            return "finished"
        }
    }
}
