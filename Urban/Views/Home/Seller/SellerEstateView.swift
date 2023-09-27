//
//  SellerEstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import FirebaseFirestore
import SwiftUI

struct SellerEstateView: View {
    @EnvironmentObject var estateManager: EstatesViewModel
    let estate: Estate

    init(estate: Estate) {
        self.estate = estate
    }

    var body: some View {
        VStack {
            CustomBackground(alignment: .leading) {
                CustomText(label: "code", value: estate.code)
                CustomText(label: "address", value: estate.address)
                CustomText(label: "createdAt", value: estate.createdAt!.toString())
                CustomText(label: "updatedAt", value: estate.updatedAt!.toString())

                Menu {
                    CustomLink("seeInBrowser", url: "\(SettingsManager.shared.getKwUrl()!)\(estate.code)")
                    NavigationLink("seeBids", destination: BidsView(estate: estate))
                    NavigationLink("seeBuyerOpinions", destination: CustomBackground {
                        Text("comingSoon")
                            .foregroundColor(ColorPalette.secondary)
                    })
                } label: {
                    Label("moreActions", systemImage: "ellipsis")
                }
            }.padding(.horizontal, 40)
        }.background(ColorPalette.primary)
    }
}

struct SellerEstateView_Previews: PreviewProvider {
    static var previews: some View {
        SellerEstateView(estate: Estate.Example()).environmentObject(EstatesViewModel.example())
    }
}
