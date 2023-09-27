//
//  CreateEstateViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

@MainActor
class CreateEstateViewModel: ObservableObject {
    @Published var estate: Estate = .init()
    @Published var allAgents: [User] = []
    @Published var sellerEmail: String = ""
    @Published var selectedAgents: Set<User> = Set([])
    
    @Published var isLoading = true
    @Published var agents: [User] = []
    @Published var created: Bool = false
    @Published var hasError: Bool = false
    @Published var showAlert: Bool = false
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
