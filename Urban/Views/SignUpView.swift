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
    
    var body: some View {
            VStack {
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
                    
                    SecureField("", text: $confirmPassword,
                              prompt: Text("Repetir password").foregroundColor(ColorPalette.secondary))
                    .listRowBackground(ColorPalette.highlights)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)

                }
                .alert(isPresented: $hasErrors) {
                    Alert(
                        title: Text("Erro"),
                        message: Text("Por favor preencha corretamente os campos"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .foregroundColor(ColorPalette.secondary)
                .scrollContentBackground(.hidden)
                
                
                Button("Criar nova conta") {
                    hasErrors = email.isEmpty || password.isEmpty || confirmPassword.isEmpty || password != confirmPassword
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        guard let user = authResult?.user, error == nil else {
                            print("Error creating user: \(error!.localizedDescription)")
                            return
                        }
                        print("User created successfully with name: \(user.email ?? "")")
                        accountCreated = true
                    }
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
