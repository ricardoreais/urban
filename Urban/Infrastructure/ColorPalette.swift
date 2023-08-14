//
//  ColorPalette.swift
//  Urban
//
//  Created by Juliana Estrela on 24/06/2023.
//

import Foundation
import SwiftUI

struct ColorPalette {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let highlights = secondary.opacity(0.2)
    static let highlightsPlus = secondary.opacity(0.8)
    static let error = Color("Error")
}
