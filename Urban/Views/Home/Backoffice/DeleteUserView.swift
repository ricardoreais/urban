//
//  DeleteUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

// TODO: We have a bug where in some cases (after a few minutes of authentication we need to re-authenticate to delete the user).
struct DeleteUserView: View {
    let userService: UserService
    
    @ObservedObject private var model: DeleteUserViewModel
    
    
    init(model: DeleteUserViewModel = DeleteUserViewModel.shared, userService: UserService = UserService()) {
        self.model = model
        self.userService = userService
    }
    
    var body: some View {
        CustomBackground {
            if model.isLoading {
                CustomLoading()
            } else {
                if(model.users.isEmpty){
                    Text("noUsers")
                }
                else{
                    List(model.users) { user in
                        HStack {
                            CustomText(label: "email", value: "\(user.email ?? "")")
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(ColorPalette.error)
                                .onTapGesture {
                                    Task{
                                        do {
                                            try await userService.delete(uid: user.id ?? "")
                                            await model.get()
                                        } catch {
                                            // Handle error
                                        }
                                    }
                                }
                       }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
    }
}

struct DeleteUserView_Previews: PreviewProvider {
    static var previews: some View {
        return DeleteUserView()
    }
}
