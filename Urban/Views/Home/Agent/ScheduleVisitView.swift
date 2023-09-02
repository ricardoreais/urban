//
//  ScheduleVisitView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct ScheduleVisitView: View {
    @ObservedObject var model: ScheduleVisitViewModel
    @State private var selectedDate = Date()
    @State private var selectedAgents: Set<User> = Set([])
    @State private var created: Bool = false
    @State private var hasError: Bool = false

    init() {
        self.model = ScheduleVisitViewModel(selectedEstate: EstatesManager.shared.selected!)
    }

    func createVisit() async {
        created = await model.createVisit(date: selectedDate, buyer: selectedAgents.first!)
        hasError = !created
    }

    var body: some View {
        CustomBackground {
            CustomForm {
                CustomSection(header: "estate") {
                    CustomDatePicker(selectedDate: $selectedDate)
                    CustomSelectList<User>(
                        label: "buyers",
                        options: model.buyers,
                        optionToString: { $0.email! },
                        selected: $selectedAgents
                    )
                    CustomButton("confirm", asyncAction: createVisit)
                        .navigationDestination(isPresented: $created) {
                            AgentHomeView()
                        }
                }
            }
            .alert(isPresented: $hasError) {
                Alert(
                    title: Text("error"),
                    message: Text("pleaseFillFieldsCorrectly"),
                    dismissButton: .default(Text("ok"))
                )
            }
        }
    }
}

struct ScheduleVisitView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            ScheduleVisitView()
        }
    }
}
