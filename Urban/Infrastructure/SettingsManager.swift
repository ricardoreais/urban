//
//  Configuration.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    
    private let bundle = Bundle.main
    
    func getKwUrl() -> String? {
        return bundle.object(forInfoDictionaryKey: "KwUrl") as? String
    }
}
