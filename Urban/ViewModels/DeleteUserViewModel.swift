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
    let userService: UserService = UserService.shared
    static let shared = DeleteUserViewModel()
    
    private init() {
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
    
    func delete(uid: String) async throws {
        return try await userService.delete(uid: uid)
    }
}
