//
//  CreateEstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 30/07/2023.
//

import SwiftUI

struct CreateEstateView: View {
    @ObservedObject private var estateManager: EstatesViewModel = EstatesViewModel.shared
    @ObservedObject private var model: CreateEstateViewModel = CreateEstateViewModel.shared
    
    func createEstate() async -> Void {
        model.created = await estateManager.create(model.estate.code, model.estate.address, model.selectedAgents, model.sellerEmail)
        model.hasError = !model.created
        model.showAlert = model.created || model.hasError
    }

    var body: some View {
        CustomBackground {
            CustomForm {
                CustomSection(header: "estate") {
                    CustomInput(text: $model.estate.code, placeholder: "id")
                        .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
                    CustomInput(text: $model.estate.address, placeholder: "address")
                    CustomSelectList<User>(
                        label: "agents",
                        options: model.agents,
                        optionToString: { $0.email! },
                        selected: $model.selectedAgents
                    )
                    CustomInput(text: $model.sellerEmail, placeholder: "sellerEmail")
                        .autocapitalization(/*@START_MENU_TOKEN@*/ .none/*@END_MENU_TOKEN@*/)
                }
                CustomButton("createEstate", asyncAction: createEstate)
                    .alert(isPresented: $model.showAlert) {
                        if model.hasError {
                            return Alert(
                                title: Text("error"),
                                message: Text("pleaseFillFieldsCorrectly"),
                                dismissButton: .default(Text("ok"))
                            )
                        } else {
                            return Alert(
                                title: Text("success"),
                                message: Text("estateCreatedWithSuccess"),
                                dismissButton: .default(Text("ok"))
                            )
                        }
                    }
            }
        }
    }
}

struct CreateEstateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{CreateEstateView().environmentObject(UserManager.example())}
    }
}
