//
//  AddUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

struct AddUserView: View {
    @State private var email: String = ""
    @State private var type: UserType = UserType.guest
    @ObservedObject private var user: UserObservable = UserObservable()
    
    func createUser() {
        let createUserCommand = CreateUserCommand(name: "", password: "123456", confirmPassword: "123456", email: email, types: [type], telephone: "")
        user.create(command: createUserCommand)
    }
    
    var body: some View {
        Form
        {
            CustomSection(header: "createUser") {
                CustomInput(text: $email, placeholder: "email")
                CustomPicker(selection: $type, label: "userType", options: [UserType.backoffice, UserType.agent, UserType.buyer, UserType.seller])
            }
            
            
            Section {
                Button("submit") {
                    createUser()
                }
                .padding(.horizontal, 0.0)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .foregroundColor(.accentColor)
            .listRowBackground(Color.clear)
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .scrollContentBackground(.hidden)
            .background(ColorPalette.primary)
    }
}
