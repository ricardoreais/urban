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
    @EnvironmentObject var userManager: UserManager
    @ObservedObject private var estateManager: EstatesManager = EstatesManager.shared
    @ObservedObject private var model: CreateEstateViewModel = CreateEstateViewModel.shared
    
    func createEstate() async -> Void {
        created = await estateManager.create(estate.code, estate.address, selectedAgents, sellerEmail)
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
                        options: model.agents,
                        optionToString: { $0.email! },
                        selected: $selectedAgents
                    )
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
        .onAppear {
            Task {
                await self.estateManager.get(uuid: userManager.current?.id ?? "")
            }
        }
    }
}

struct CreateEstateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEstateView().environmentObject(UserManager.example())
    }
}
