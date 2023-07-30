//
//  CreateEstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import SwiftUI

struct CreateEstateView: View {
    @State private var estate: Estate = Estate()
    @State private var allAgents: [User] = []
    @State private var selectedAgents: [User] = []
    @State private var sellerEmail: String = ""
    
    var body: some View {
        VStack{
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
        }
    }
}

struct CreateEstateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEstateView()
            .scrollContentBackground(.hidden)
            .background(ColorPalette.primary)
    }
}
