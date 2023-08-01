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
    @ObservedObject var user: UserObservable = UserObservable()
    @State private var selected: Set<IdentifiableString> = Set([].map { IdentifiableString(string: $0) })
    
    var body: some View {
        VStack{
            Form
            {
                CustomSection(header: "estate") {
                    CustomInput(text:$estate.code, placeholder: "id")
                    CustomInput(text:$estate.address, placeholder: "address")
                    CustomSelectList<IdentifiableString>(
                        label: "agents",
                        options: user.users.map{ $0.email ?? "" }.map { IdentifiableString(string: $0) },
                        optionToString: { $0.string },
                        selected: $selected
                    )
                    .onAppear(perform: {
                        user.getAll()
                    })
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
