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
    
    func openInPreview() {}

    var body: some View {
        NavigationView {
            CustomBackground(alignment: .leading) {
                CustomText(label: "code", value: estate.code)
                CustomText(label: "address", value: estate.address)
                CustomText(label: "createdAt", value: estate.createdAt!.toString())
                CustomText(label: "updatedAt", value: estate.updatedAt!.toString())
                
                Menu {
                    //NavigationLink("createVisitReport", destination: VisitReportFormView(visit: Visit))
                    CustomLink("seeInBrowser", url: "\(SettingsManager.shared.getKwUrl()!)\(estate.code)")
                    NavigationLink("scheduleVisit", destination: ScheduleVisitView().environmentObject(estateManager))
                    NavigationLink("createBid", destination: CreateBidView())
                } label: {
                    Label("moreActions", systemImage: "ellipsis")
                }
            }
        }.onAppear{
            estateManager.setSelected(estate)
        }
    }
}

struct EstateView_Previews: PreviewProvider {
    static var previews: some View {
        return EstateView(estate: Estate.Example()).environmentObject(EstatesViewModel.example())
    }
}
