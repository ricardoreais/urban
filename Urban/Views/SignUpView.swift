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
    @EnvironmentObject var userManager: UserManager
    
    
    func signUp() async -> Void {
        let result = await userManager.signUp(email, password, confirmPassword)
        hasErrors = result == false
        accountCreated = result == true
    }
    
    var body: some View {
        CustomBackground {
            Logo()
            CustomForm {
                CustomInput(text: $email, placeholder: "email")
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .listRowBackground(ColorPalette.highlights)
                CustomSecureField(text: $password, placeholder: "password")
                    .listRowBackground(ColorPalette.highlights)
                CustomSecureField(text: $confirmPassword, placeholder: "repeatPassword")
                    .listRowBackground(ColorPalette.highlights)
            }
            .alert(isPresented: $hasErrors) {
                Alert(
                    title: Text("error"),
                    message: Text("pleaseFillFieldsCorrectly"),
                    dismissButton: .default(Text("ok"))
                )
            }
            CustomButton("signUp", asyncAction: signUp)
                .navigationDestination(isPresented: $accountCreated) {
                    SignInView()
                }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
