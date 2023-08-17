//
//  ScheduleVisitViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class ScheduleVisitViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var buyers: [User] = []
    
    let userService: UserServiceProtocol
    
    static let shared = ScheduleVisitViewModel(userService: UserService())
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
        Task {
            await get()
        }
    }
    
    func get() async -> Void {
        Task {
            do {
                self.buyers = try await userService.get(.buyer)
                self.isLoading = false
            } catch {
                // Handle fetching users by type errors
            }
        }
    }
}
