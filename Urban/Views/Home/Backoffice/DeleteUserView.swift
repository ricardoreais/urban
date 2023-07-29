//
//  DeleteUserView.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import SwiftUI

struct DeleteUserView: View {
    @ObservedObject var user: UserObservable = UserObservable()
    
    var body: some View {
        VStack {
            Text("HElloww2")
            if user.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .scaleEffect(2)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                if(user.users.isEmpty){
                    Text("noVisitsYet")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else{
                    List(user.users) { user in
                        CustomText(label: "clientName", value: user.email ?? "") +
                        CustomText(label: "code", value: user.id ?? "")
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.red)
                    }
                    
                }
            }
        }
        .onAppear(perform: {
            user.getAll()
        })
    }
}

struct DeleteUserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserObservable()
        let user1 = User(id: "1", createdAt: Date(), updatedAt: Date(), name: "John Doe", email: "john@example.com", telephone: "123456789", types: [.backoffice, .buyer])
        let user2 = User(id: "2", createdAt: Date(), updatedAt: Date(), name: "Jane Smith", email: "jane@example.com", telephone: "987654321", types: [.agent])
        let user3 = User(id: "3", createdAt: Date(), updatedAt: Date(), name: "Bob Johnson", email: "bob@example.com", telephone: "555555555", types: [.seller])
        user.users = [user1, user2, user3]
        user.isLoading = false
        return DeleteUserView(user: user)
    }
}
