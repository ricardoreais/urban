//
//  AddUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

struct AddUserView: View {
    let userService: UserService
    
    @State private var email: String = ""
    @State private var type: UserType = UserType.guest
    @ObservedObject private var user: UserObservable = UserObservable.shared
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func createUser() async -> Void {
        let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [type], telephone: "")
        _ = await userService.create(command: createUserCommand)
    }
    
    var body: some View {
        CustomBackground{
            CustomForm
            {
                CustomSection(header: "createUser") {
                    CustomInput(text: $email, placeholder: "email")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    CustomPicker(selection: $type, label: "userType", options: [UserType.backoffice, UserType.agent, UserType.buyer, UserType.seller])
                }
                CustomButton("submit", asyncAction: createUser)
            }}
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
    }
}
