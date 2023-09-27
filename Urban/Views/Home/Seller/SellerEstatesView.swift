//
//  EstatesView.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import SwiftUI

struct SellerEstatesView: View {
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var estateManager: EstatesViewModel = .shared
    
    var body: some View {
        CustomBackground {
            if estateManager.isLoading {
                CustomLoading()
            } else {
                Logo()
                if(estateManager.estates.isEmpty){
                    Text("noPropertiesYet")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else if (estateManager.estates.count == 1) {
                    SellerEstateView(estate: estateManager.estates[0])
                }
                else {
                    List(estateManager.estates) { estate in
                        NavigationLink(destination: SellerEstateView(estate: estate)) {
                            CustomText(label: "property", value: estate.address)
                        }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await self.estateManager.getBySeller(uuid: userManager.current?.id ?? "")
            }
        }
    }
}

struct SellerEstatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{SellerEstatesView(estateManager: EstatesViewModel.example()).environmentObject(UserManager.example())}
    }
}
