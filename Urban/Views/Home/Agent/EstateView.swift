//
//  EstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct EstateView: View {
    let estate: Estate
    @ObservedObject var estateObs: EstateObservable
    @ObservedObject var visitObs: VisitObservable
    @ObservedObject private var userObs: UserObservable = .shared

    func openInPreview() {}

    var body: some View {
        CustomBackground(alignment: .leading) {
            CustomText(label: "code", value: estate.code)
            CustomText(label: "address", value: estate.address)
            CustomText(label: "createdAt", value: estate.createdAt!.toString())
            CustomText(label: "updatedAt", value: estate.updatedAt!.toString())

            Menu {
                Button("createVisitReport", action: openInPreview)
                CustomLink("seeInBrowser", url: "\(SettingsManager.shared.getKwUrl()!)\(estate.code)")
                NavigationLink("scheduleVisit", destination: ScheduleVisitView(visitObs: visitObs))
                Button("createBid", action: openInPreview)
            } label: {
                Label("moreActions", systemImage: "ellipsis")
            }
        }
        .onAppear(perform: {
            estateObs.setSelected(estate)
        })
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
        let userObs = UserObservable.shared
        let estateObs = EstateObservable(user: userObs)
        return NavigationView {
            EstateView(estate: estate, estateObs: estateObs, visitObs: VisitObservable(user: userObs, estateObs: estateObs))
        }
    }
}
