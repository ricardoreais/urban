//
//  BackOfficeHomeView.swift
//  Urban
//
//  Created by Juliana Estrela on 08/07/2023.
//

import SwiftUI

struct BackofficeHomeView: View {
    @State private var estate: Estate = Estate()
    @State private var allAgents: [User] = []
    @State private var selectedAgents: [User] = []
    @State private var sellerEmail: String = ""
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

    var body: some View {
        TabView {
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
                
                Form
                {
                    CustomSection(header: "estate") {
                        CustomInput(text:$estate.code, placeholder: "id")
                        CustomInput(text:$estate.address, placeholder: "address")
                        Picker("Select an option", selection: $sellerEmail) {
                            ForEach(allAgents) { agent in
                                Text(agent.name ?? "NA").tag(agent.id)
                            }
                        }
                        .pickerStyle(DefaultPickerStyle())
                        .padding()
                        
                        
                        CustomInput(text:$estate.address, placeholder: "agents")
                        CustomInput(text:$sellerEmail, placeholder: "sellerEmail")
                    }
                }
                .scrollContentBackground(.hidden)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 2)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("createEstate", systemImage: "square.grid.3x1.folder.badge.plus")
            }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("updateUser", systemImage: "person.badge.shield.checkmark")
            }
            VStack{
                AddUserView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("addUser", systemImage: "person.badge.plus")
            }
            VStack{
                Text("comingSoon")
                    .foregroundColor(ColorPalette.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.primary)
            .tabItem {
                Label("deleteUser", systemImage: "person.badge.minus")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct BackofficeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BackofficeHomeView()
    }
}
