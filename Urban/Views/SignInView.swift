//
//  SignInView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @State private var hasErrors: Bool = false
    // TODO: Set current user in user manager observable
    @ObservedObject var user = UserObservable.shared
    let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func signIn() async -> Void {
        let result = await userService.signIn(email, password)
        hasErrors = email.isEmpty || password.isEmpty
        hasErrors = result.hasErrors
        loggedIn = result.loggedIn
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
            }
            .alert(isPresented: $hasErrors) {
                Alert(
                    title: Text("error"),
                    message: Text("notPossibleToLogin"),
                    dismissButton: .default(Text("ok"))
                )
            }
            CustomButton("signIn", asyncAction: signIn)
                .navigationDestination(isPresented: $loggedIn) {
                    HomeView()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
