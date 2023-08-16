//
//  DeleteUserViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class DeleteUserViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var users: [User] = []
    
    let userService: UserService
    
    static let shared = DeleteUserViewModel(userService: UserService())
    
    private init(userService: UserService) {
        self.userService = userService
        Task {
            await get()
        }
    }
    
    func get() async -> Void {
        Task {
            do {
                self.users = try await userService.get()
                self.isLoading = false
            } catch {
                // Handle fetching users by type errors
            }
        }
    }
}
