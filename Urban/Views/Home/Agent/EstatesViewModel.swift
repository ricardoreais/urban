//
//  EstatesViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class EstatesViewModel: ObservableObject {
    @Published var estates: [Estate] = []
    @Published var selected: Estate? = nil
    @Published var isLoading = true
    
    let estateService: EstateService
    
    static let shared = EstatesViewModel()
    
    private init(estateService: EstateService = EstateService(userManager: UserManager.shared, userService: UserService())) {
        self.estateService = estateService
        Task{
            await get()
        }
    }
    
    func setSelected(_ estate: Estate) {
        selected = estate
    }
    
    func createEstate(command: CreateEstateCommand) async -> Bool {
        return await estateService.create(command: command)
    }
    
    func get() async {
        self.estates = await estateService.get()
        self.isLoading = false
    }
}
