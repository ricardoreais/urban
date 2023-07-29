//
//  SignUpView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var accountCreated: Bool = false
    @State private var hasErrors: Bool = false
    @ObservedObject private var user: UserObservable = UserObservable()
    
    
    func signUp() -> Void {
        let createUserCommand = CreateUserCommand(name: "", password: password, confirmPassword: confirmPassword, email: email, types: [UserType.buyer], telephone: "")
        let result = user.create(command: createUserCommand)
        
        hasErrors = result == false
        accountCreated = result == true
    }
    
    var body: some View {
            VStack {
                Logo()
                Form {
                    TextField("", text: $email,
                              prompt: Text("email").foregroundColor(ColorPalette.secondary))
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .listRowBackground(ColorPalette.highlights)
                    
                    SecureField("", text: $password,
                              prompt: Text("password").foregroundColor(ColorPalette.secondary))
                    .listRowBackground(ColorPalette.highlights)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("", text: $confirmPassword,
                              prompt: Text("repeatPassword").foregroundColor(ColorPalette.secondary))
                    .listRowBackground(ColorPalette.highlights)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)

                }
                .alert(isPresented: $hasErrors) {
                    Alert(
                        title: Text("error"),
                        message: Text("pleaseFillFieldsCorrectly"),
                        dismissButton: .default(Text("ok"))
                    )
                }
                .foregroundColor(ColorPalette.secondary)
                .scrollContentBackground(.hidden)
                
                
                Button("signUp") {
                    signUp()
                }.navigationDestination(isPresented: $accountCreated) {
                    SignInView()
                }
                .listRowBackground(Color.clear)
                .padding(.horizontal, 0.0)
                .frame(maxWidth: .infinity, alignment: .center)
            }.background(ColorPalette.primary)
        }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
