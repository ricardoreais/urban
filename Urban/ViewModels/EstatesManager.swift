//
//  EstatesViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

@MainActor
class EstatesManager: ObservableObject {
    @Published var estates: [Estate] = []
    @Published var selected: Estate? = nil
    @Published var isLoading = true
    let estateService: EstateService = EstateService.shared
    let userService: UserService = UserService.shared
    
    static let shared = EstatesManager()
    private init() {}
    
    func setSelected(_ estate: Estate) {
        selected = estate
    }
    
    func create(_ code: String, _ address: String, _ agents: Set<User>, _ sellerEmail: String) async -> Bool {
        let createEstateCommand = CreateEstateCommand(code: code, address: address, agents: agents.map { userService.convertToDocumentReference($0.id!) }, sellerEmail: sellerEmail)
        return await estateService.create(command: createEstateCommand)
    }
    
    func get(uuid: String) async {
        self.estates = await self.estateService.get(uuid: uuid)
        self.isLoading = false
    }
    
    static func example() -> EstatesManager {
        let estatesManager = EstatesManager()
        estatesManager.estates = [Estate.Example()]
        estatesManager.isLoading = false
        estatesManager.selected = Estate.Example()
        return estatesManager
    }
}
