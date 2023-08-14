//
//  Configuration.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import Foundation

struct AppConfiguration {
    var websiteURL: URL
}

class ConfigurationService: ObservableObject {
    static let singleton = ConfigurationService()
    @Published var value: AppConfiguration?
    
    private init() {
        let websiteURL = UserDefaults.standard.url(forKey: "websiteURL") ?? URL(string: "https://www.kwportugal.pt/")!
        self.value = AppConfiguration(websiteURL: websiteURL)
    }
}
