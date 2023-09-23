//
//  EstateView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct EstateView: View {
    @EnvironmentObject var estateManager: EstatesViewModel
    let estate: Estate

    init(estate: Estate) {
        self.estate = estate
    }
    
    func openInPreview() {}

    var body: some View {
        NavigationView {
            CustomBackground(alignment: .leading) {
                CustomText(label: "code", value: estate.code)
                CustomText(label: "address", value: estate.address)
                CustomText(label: "createdAt", value: estate.createdAt!.toString())
                CustomText(label: "updatedAt", value: estate.updatedAt!.toString())
                
                Menu {
                    NavigationLink("createVisitReport", destination: VisitReportFormView())
                    CustomLink("seeInBrowser", url: "\(SettingsManager.shared.getKwUrl()!)\(estate.code)")
                    NavigationLink("scheduleVisit", destination: ScheduleVisitView())
                    Button("createBid", action: openInPreview)
                } label: {
                    Label("moreActions", systemImage: "ellipsis")
                }
            }
        }
    }
}

struct EstateView_Previews: PreviewProvider {
    static var previews: some View {
        return EstateView(estate: Estate.Example()).environmentObject(EstatesViewModel.example())
    }
}
