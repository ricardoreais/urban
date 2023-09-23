//
//  EstatesViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

@MainActor
class EstatesViewModel: ObservableObject {
    @Published var estates: [Estate] = []
    @Published var selected: Estate? = nil
    @Published var isLoading = true
    let estateService: EstateService = .shared
    let userService: UserService = .shared
    
    static let shared = EstatesViewModel()
    private init() {}
    
    func setSelected(_ estate: Estate) {
        self.selected = estate
    }
    
    func create(_ code: String, _ address: String, _ agents: Set<User>, _ sellerEmail: String) async -> Bool {
        let createEstateCommand = CreateEstateCommand(code: code, address: address, agents: agents.map { self.userService.convertToDocumentReference($0.id!) }, sellerEmail: sellerEmail)
        return await self.estateService.create(command: createEstateCommand)
    }
    
    func getByAgent(uuid: String) async {
        if self.estates.isEmpty {
            self.isLoading = true
            self.estates = await self.estateService.getByAgent(uuid: uuid)
            self.isLoading = false
        }
    }
    
    func getBySeller(uuid: String) async {
        if self.estates.isEmpty {
            self.isLoading = true
            self.estates = await self.estateService.getBySeller(uuid: uuid)
            self.isLoading = false
        }
    }
    
    static func example() -> EstatesViewModel {
        let estatesManager = EstatesViewModel()
        estatesManager.estates = [Estate.Example()]
        estatesManager.isLoading = false
        estatesManager.selected = Estate.Example()
        return estatesManager
    }
}
