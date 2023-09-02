//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//
import Foundation

@MainActor
class UserManager: ObservableObject {
    @Published var current: User?
    @Published var isLoading = true
    let userService: UserService = .shared
    
    static let shared = UserManager()
    
    private init() {}
    
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
    
    func signIn(_ email: String, _ password: String) async -> (loggedIn: Bool, hasErrors: Bool) {
        let result = await userService.signIn(email, password)
        await getCurrent()
        return result
    }
    
    func createUser(_ email: String, _ password: String, _ confirmPassword: String, _ userType: UserType) async -> Bool {
        let createUserCommand = CreateUserCommand(name: "", password: password, confirmPassword: confirmPassword, email: email, types: [userType], telephone: "")
        let result = await userService.create(command: createUserCommand)
        return result
    }
    
    func signUp(_ email: String, _ password: String, _ confirmPassword: String) async -> Bool {
        let createUserCommand = CreateUserCommand(name: "", password: password, confirmPassword: confirmPassword, email: email, types: [UserType.guest], telephone: "")
        let result = await userService.create(command: createUserCommand)
        return result
    }
    
    func example() -> UserManager {
        let userManager = UserManager()
        userManager.current = User.AdminExample()
        return userManager
    }
}
