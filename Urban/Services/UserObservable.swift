//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//
import Foundation

class UserObservable: ObservableObject {
    @Published var value: User = User()
    @Published var isLoading = true
    
    let userService: UserService
    
    static let shared = UserObservable(userService: UserService())
    
    private init(userService: UserService) {
        self.userService = userService
        Task {
            await getCurrent()
        }
    }
    
    func getCurrent() async -> Void {
        if let user = await userService.getCurrent() {
            DispatchQueue.main.async {
                self.isLoading = false
                self.value = user
            }
        } else {
            // Handle fetching user errors
        }
    }
}
