//
//  AddUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

struct AddUserView: View {
    @State private var email: String = ""
    @State private var type: UserType = UserType.backoffice
    @State private var created: Bool = false
    @State private var generatedPassword: String = ""
    
    let buyerCreation: Bool
    @EnvironmentObject var userManager: UserManager
    
    init(buyerCreation: Bool = false) {
        self.buyerCreation = buyerCreation
    }
    
    func generateRandomPassword() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var password = ""
        
        for _ in 1...6 {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            password.append(randomCharacter)
        }
        
        return password
    }
    
    func createUser() async -> Void {
        generatedPassword = generateRandomPassword()
        created = await userManager.createUser(email, generatedPassword, generatedPassword, buyerCreation ? .buyer : type)
    }
    
    var body: some View {
        CustomBackground {
            Logo()
            CustomForm
            {
                CustomSection(header: "createUser") {
                    CustomInput(text: $email, placeholder: "email")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    if !buyerCreation {
                        CustomPicker(selection: $type, label: "userType", options: [UserType.backoffice, UserType.agent, UserType.buyer, UserType.seller])
                    }
                }
                CustomButton("submit", asyncAction: createUser)
                    .alert(isPresented: $created) {
                        Alert(
                                title: Text("success"),
                                message: Text("userSuccessfullyCreated") + Text(generatedPassword),
                                dismissButton: .default(Text("ok"))
                            )
                    }
            }}
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView().environmentObject(UserManager.example())
    }
}
