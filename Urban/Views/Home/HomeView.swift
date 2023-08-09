//
//  SandboxView.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var user = UserObservable()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = ColorPalette.secondary.uiColor()
    }

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
                      Text("User types not available")
                  }
              }
        }
        .onAppear(perform: {
            user.fetch()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
