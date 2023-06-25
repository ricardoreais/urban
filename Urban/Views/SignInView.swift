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
    
    
    func signIn() {
        hasErrors = email.isEmpty || password.isEmpty
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                hasErrors = true
                // Handle sign-in error
                print("Sign-in failed: \(error.localizedDescription)")
            } else {
                // Sign-in successful, do something
                print("Sign-in successful!")
                loggedIn = true;
            }
        }
    }
    
    var body: some View {
        VStack{
            LogoView()
            Form {
                TextField("", text: $email,
                          prompt: Text("Email").foregroundColor(ColorPalette.secondary))
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .listRowBackground(ColorPalette.highlights)
                
                SecureField("", text: $password,
                            prompt: Text("Password").foregroundColor(ColorPalette.secondary))
                .listRowBackground(ColorPalette.highlights)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $hasErrors) {
                Alert(
                    title: Text("Erro"),
                    message: Text("Não foi possivel efetuar o login, valide o seu email/password"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .foregroundColor(ColorPalette.secondary)
            .scrollContentBackground(.hidden)
            
            Button("Sign In") {
                signIn()
            }.navigationDestination(isPresented: $loggedIn) {
                HomeView()
            }
            .padding(.horizontal, 0.0)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(ColorPalette.primary)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
