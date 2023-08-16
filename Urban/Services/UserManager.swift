//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//
import Foundation

class UserManager: ObservableObject {
    @Published var current: User = User()
    @Published var isLoading = true
    
    let userService: UserServiceProtocol
    
    static let shared = UserManager(userService: UserService())
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
        Task {
            await getCurrent()
        }
    }
    
    func getCurrent() async -> Void {
        if let user = await userService.getCurrent() {
            DispatchQueue.main.async {
                self.isLoading = false
                self.current = user
            }
        } else {
            // Handle fetching user errors
        }
    }
}
