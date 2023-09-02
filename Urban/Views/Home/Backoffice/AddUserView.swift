//
//  AddUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

struct AddUserView: View {
    @State private var email: String = ""
    @State private var type: UserType = UserType.guest
    @EnvironmentObject var userManager: UserManager
    
    func createUser() async -> Void {
        _ = await userManager.createUser(email, "123456", "123456", type)
    }
    
    var body: some View {
        CustomBackground{
            CustomForm
            {
                CustomSection(header: "createUser") {
                    CustomInput(text: $email, placeholder: "email")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    CustomPicker(selection: $type, label: "userType", options: [UserType.backoffice, UserType.agent, UserType.buyer, UserType.seller])
                }
                CustomButton("submit", asyncAction: createUser)
            }}
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView().environmentObject(UserManager.example())
    }
}
