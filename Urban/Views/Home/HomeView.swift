//
//  SandboxView.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @ObservedObject var user: UserObservable = UserObservable();

    var body: some View {
        CustomBackground {
            if user.isLoading {
                    CustomLoading()
              } else {
                  // Depending on the user type, show different views
                  if let userTypes = user.value.types {
                      if userTypes.contains(UserType.admin) {
                          BackofficeHomeView()
                      } else if userTypes.contains(UserType.buyer) {
                          BuyerHomeView()
                      }
                      else if userTypes.contains(UserType.agent) {
                         AgentHomeView()
                     }
                      else if userTypes.contains(UserType.seller) {
                         SellerHomeView()
                     }
                      else if userTypes.contains(UserType.backoffice) {
                          BackofficeHomeView()
                      } else {
                          // Handle other user types or show a default view
                          Text("Unknown user type")
                      }
                  } else {
                      // Handle the case when user.types is nil or show a default view
                      Text("Unexpected exception, please contact us")
                  }
              }
        }
        .environmentObject(user) // Inject the shared instance of the user observable.
        .onAppear {
            Task {
                await user.getCurrent()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let userObs = UserObservable()
        let currentUser = User(
            id: "user123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "John Doe",
            email: "john@example.com",
            telephone: "123-456-7890",
            types: [ .backoffice ]
        )
        userObs.isLoading = false
        userObs.value = currentUser
        return HomeView(user: userObs)
    }
}
