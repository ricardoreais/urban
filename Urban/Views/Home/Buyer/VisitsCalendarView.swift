//
//  VisitsCalendarView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct VisitsCalendarView: View {
    @ObservedObject var visitObs: VisitObservable

    private let dateFormatter: DateFormatter

    init(visitObs: VisitObservable = .shared) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM HH:mm"
        self.dateFormatter = dateFormatter
        self.visitObs = .shared
    }

    var body: some View {
        CustomBackground {
            if visitObs.isLoading {
                CustomLoading()
            } else {
                if visitObs.values.isEmpty {
                    Text("noScheduledVisitsYet")
                } else {
                    List(visitObs.values) { visit in
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
        .onAppear(perform: {
            Task {
                await visitObs.get()
            }
        })
    }
}

struct VisitsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let visitObs = VisitObservable.shared
        visitObs.isLoading = false
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
        visitObs.values = [firstVisit]
        return
            NavigationView {
                VisitsCalendarView(visitObs: visitObs)
            }
    }
}
