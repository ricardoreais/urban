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
    private let userService: UserService = UserService.shared
    
    static let shared = CreateEstateViewModel()
    
    private init() {
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
