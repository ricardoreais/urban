//
//  VisitsCalendarView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct VisitsCalendarView: View {
    @ObservedObject var model: VisitsCalendarViewModel

    private let dateFormatter: DateFormatter

    init(model: VisitsCalendarViewModel = .shared) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM HH:mm"
        self.dateFormatter = dateFormatter
        self.model = model
    }

    var body: some View {
        CustomBackground {
            if model.isLoading {
                CustomLoading()
            } else {
                if model.visits.isEmpty {
                    Text("noScheduledVisitsYet")
                } else {
                    List(model.visits) { visit in
                        Menu {
                            NavigationLink("createVisitReport", destination: VisitReportFormView())
                            CustomLink("seeInBrowser", url: "\(SettingsManager.shared.getKwUrl()!)\("1208-4267")")
                        } label: {
                            CustomText(label: "property", value: "1208-4267")
                            CustomText(label: "day", value: dateFormatter.string(from: visit.date!))
                        }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
    }
}

struct VisitsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let model = VisitsCalendarViewModel.shared
        model.isLoading = false
        let estateReference = Firestore.firestore().collection("estates").document("estateID")
        let buyerReference = Firestore.firestore().collection("buyers").document("buyerID")
        let agentReference = Firestore.firestore().collection("agents").document("agentID")
        let firstVisit = Visit(
            id: "visitID1",
            createdAt: Timestamp(date: Date()), // Simulated timestamp
            updatedAt: Timestamp(date: Date()), // Simulated timestamp
            date: Date(),
            estate: estateReference,
            reports: [Firestore.firestore().collection("reports").document("reportID1")],
            buyer: buyerReference,
            agent: agentReference
        )
        model.visits = [firstVisit]
        return
            NavigationView {
                VisitsCalendarView(model: model)
            }
    }
}
