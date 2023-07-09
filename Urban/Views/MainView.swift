//
//  HomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 27/05/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Logo()
                NavigationLink("login", destination: SignInView())
                NavigationLink("signUp", destination: SignUpView())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
