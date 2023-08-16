//
//  CreateEstateViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class CreateEstateViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var agents: [User] = []
    
    let userService: UserService
    
    static let shared = CreateEstateViewModel(userService: UserService())
    
    private init(userService: UserService) {
        self.userService = userService
        Task {
            await get()
        }
    }
    
    func get() async -> Void {
        Task {
            do {
                self.agents = try await userService.get(.agent)
                self.isLoading = false
            } catch {
                // Handle fetching users by type errors
            }
        }
    }
}
