//
//  HomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 27/05/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var userManager: UserManager = .shared
    
    var body: some View {
        NavigationStack {
            CustomBackground {
                Logo()
                Spacer()
                Text("slogan")
                    .frame(width: 275)
                    .font(.custom("Snell Roundhand", size: 30))
                Spacer()
                NavigationLink("login", destination: SignInView())
                    .foregroundColor(.accentColor)
                NavigationLink("signUp", destination: SignUpView())
                    .foregroundColor(.accentColor)
            }
        }.environmentObject(userManager)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
