//
//  VisitsCalendarView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct VisitsCalendarView: View {
    @ObservedObject var visitsStore: VisitsCalendarViewModel
    private let dateFormatter: DateFormatter

    init(visitsStore: VisitsCalendarViewModel = .shared) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM HH:mm"
        self.dateFormatter = dateFormatter
        self.visitsStore = visitsStore
    }

    var body: some View {
        NavigationView {
            CustomBackground {
                if visitsStore.isLoading {
                    CustomLoading()
                } else {
                    if visitsStore.visits.isEmpty {
                        Text("noScheduledVisitsYet")
                    } else {
                        List(visitsStore.visits) { visit in
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
}

struct VisitsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsCalendarView(visitsStore: VisitsCalendarViewModel.example())
    }
}
