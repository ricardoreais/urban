//
//  CreateEstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import SwiftUI

struct CreateEstateView: View {
    @State private var estate: Estate = .init()
    @State private var allAgents: [User] = []
    @State private var sellerEmail: String = ""
    @State private var created: Bool = false
    @State private var hasError: Bool = false
    @State private var selectedAgents: Set<User> = Set([])

    @ObservedObject private var user: UserObservable = .shared
    @ObservedObject private var estateObs: EstateObservable = .shared

    func createEstate() async -> Void {
        let createEstateCommand = CreateEstateCommand(code: estate.code, address: estate.address, agents: selectedAgents.map { user.convertToDocumentReference($0.id!) }, sellerEmail: sellerEmail)
        created = await estateObs.create(command: createEstateCommand)
        hasError = !created
    }

    var body: some View {
        CustomBackground {
            CustomForm {
                CustomSection(header: "estate") {
                    CustomInput(text: $estate.code, placeholder: "id")
                        .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
                    CustomInput(text: $estate.address, placeholder: "address")
                    CustomSelectList<User>(
                        label: "agents",
                        options: user.users,
                        optionToString: { $0.email! },
                        selected: $selectedAgents
                    )
                    .onAppear(perform: {
                        user.get(type: .agent)
                    })
                    CustomInput(text: $sellerEmail, placeholder: "sellerEmail")
                        .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
                }
                CustomButton("createEstate", asyncAction: createEstate)
            }
            .alert(isPresented: $created) {
                Alert(
                    title: Text("success"),
                    message: Text("estateCreatedWithSuccess"),
                    dismissButton: .default(Text("ok"))
                )
            }
            .alert(isPresented: $hasError) {
                Alert(
                    title: Text("error"),
                    message: Text("pleaseFillFieldsCorrectly"),
                    dismissButton: .default(Text("ok"))
                )
            }
        }
    }
}

struct CreateEstateView_Previews: PreviewProvider {
    static var previews: some View {
        return CreateEstateView()
    }
}
