//
//  DeleteUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

// TODO: We have a bug where in some cases (after a few minutes of authentication we need to re-authenticate to delete the user).
struct DeleteUserView: View {
    @ObservedObject private var user: UserObservable = UserObservable.shared
    
    var body: some View {
        CustomBackground {
            if user.isLoading {
                CustomLoading()
            } else {
                if(user.users.isEmpty){
                    Text("noUsers")
                }
                else{
                    List(user.users) { user in
                        HStack {
                            CustomText(label: "email", value: "\(user.email ?? "")")
                            Spacer()
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(ColorPalette.error)
                                .onTapGesture {
                                    self.user.delete(uid: user.id ?? "") { error in
                                        if error != nil {
                                        } else {
                                            self.user.get()
                                        }
                                    }
                                }
                       }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
        .onAppear(perform: {
            user.get()
        })
    }
}

struct DeleteUserView_Previews: PreviewProvider {
    static var previews: some View {
        return DeleteUserView()
    }
}
