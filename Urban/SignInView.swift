//
//  SignInView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/05/2023.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State public var route: Route
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
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
                Button("Sign In") {
                    signIn()
                }.navigationDestination(isPresented: $loggedIn) {
                    VisitReportFormView()
                }
                .padding(.horizontal, 0.0)
                .frame(maxWidth: .infinity, alignment: .center)
            }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(route: Route.signIn)
    }
}
