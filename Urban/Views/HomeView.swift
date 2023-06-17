//
//  HomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 27/05/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Efetuar login", value: Route.signIn)
                NavigationLink("Criar nova conta", value: Route.signUp)
            }.navigationDestination(for: Route.self) { route in
                switch route {
                    case Route.signIn:
                        SignInView(route: route)
                    case Route.signUp:
                        SignUpView()
                    default:
                        HomeView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
