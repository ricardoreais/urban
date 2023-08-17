//
//  EstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct EstateView: View {
    @ObservedObject var estateStore: EstatesStore
    let estate: Estate

    init(estate: Estate, estateStore: EstatesStore) {
        self.estateStore = estateStore
        self.estate = estate
    }
    
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
                NavigationLink("scheduleVisit", destination: ScheduleVisitView(estatesStore: estateStore))
                Button("createBid", action: openInPreview)
            } label: {
                Label("moreActions", systemImage: "ellipsis")
            }
        }.onAppear(perform: {
            estateStore.setSelected(estate)
        })
    }
}

struct EstateView_Previews: PreviewProvider {
    static var previews: some View {
        let estateServiceMock: EstateServiceMock = EstateServiceMock()
        let estateStore: EstatesStore = EstatesStore(estateService: estateServiceMock)
        return NavigationView {EstateView(estate: estateServiceMock.estate1, estateStore: estateStore)}
    }
}
