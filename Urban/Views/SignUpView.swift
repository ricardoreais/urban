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
    
    var body: some View {
            VStack {
                Form {
                    TextField(
                        "Email",
                        text: $email
                    )
                    .background(Color.clear)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    TextField(
                        "Password",
                        text: $password
                    )
                    .background(Color.clear)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Button("Criar nova conta") {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            guard let user = authResult?.user, error == nil else {
                                print("Error creating user: \(error!.localizedDescription)")
                                return
                            }
                            print("User created successfully with name: \(user.email ?? "")")
                        }
                    }
                    .padding(.horizontal, 0.0)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
