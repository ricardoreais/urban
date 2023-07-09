//
//  LocalizedEnum.swift
//  Urban
//
//  Created by Juliana Estrela on 09/07/2023.
//

import Foundation
import SwiftUI

protocol LocalizedEnum: Hashable {
    var rawValue: LocalizedStringKey { get }
}
