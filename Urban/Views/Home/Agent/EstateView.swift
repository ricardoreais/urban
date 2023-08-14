//
//  EstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import SwiftUI
import FirebaseFirestore

struct EstateView: View {
    @EnvironmentObject var configurationService: ConfigurationService
    let estate: Estate

    var body: some View {
        CustomBackground {
            CustomText(label: "code", value: estate.code)
            CustomText(label: "address", value: estate.address)
            CustomText(label: "createdAt", value: estate.createdAt!.toString())
            CustomText(label: "updateAt", value: estate.updatedAt!.toString())
            CustomLink(url: "\((configurationService.value?.websiteURL)!)\(estate.code)")
        }
    }
}

struct EstateView_Previews: PreviewProvider {
    static var previews: some View {
        let createdTimestamp = Timestamp(date: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!)
        let updatedTimestamp = Timestamp(date: Calendar.current.date(bySettingHour: 13, minute: 0, second: 0, of: Date())!)
        let estate = Estate(
            id: "someID",
            createdAt: createdTimestamp,
            updatedAt: updatedTimestamp,
            code: "ABC123",
            address: "123 Main St",
            seller: nil,
            agents: nil,
            visits: nil,
            bids: nil
        )
        EstateView(estate: estate)
            .environmentObject(ConfigurationService.singleton)
    }
}
