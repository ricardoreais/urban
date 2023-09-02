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
    @EnvironmentObject var userManager: UserManager
    
    func signIn() async -> Void {
        do {
            let result = await userManager.signIn(email, password)
            try await Task.sleep(until: .now + .seconds(10), clock: .continuous)
            
            let isEmptyEmailOrPassword = email.isEmpty || password.isEmpty
            hasErrors = result.hasErrors || isEmptyEmailOrPassword
            loggedIn = result.loggedIn && !hasErrors
        } catch {
            // Handle the error here
            print("Error during sign-in: \(error)")
            // You can set an error state or show an alert to the user, etc.
        }
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
