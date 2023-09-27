//
//  ScheduleVisitView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct ScheduleVisitView: View {
    @EnvironmentObject var estateManager: EstatesViewModel
    @ObservedObject var model: ScheduleVisitViewModel = .shared
    @State private var selectedDate = Date()
    @State private var selectedAgents: Set<User> = Set([])
    @State private var created: Bool = false
    @State private var hasError: Bool = false
    
    func createVisit() async {
        created = await model.createVisit(estate: estateManager.selected!, date: selectedDate, buyer: selectedAgents.first!)
        hasError = !created
    }

    var body: some View {
        CustomBackground {
            CustomForm {
                CustomSection(header: "estate") {
                    CustomDatePicker(selectedDate: $selectedDate)
                }
                CustomSection(header: "selectBuyer"){
                    CustomSelectList<User>(
                        label: "buyers",
                        options: model.buyers,
                        optionToString: { $0.email! },
                        selected: $selectedAgents
                    )
                }
                Section{
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
            ScheduleVisitView(model: ScheduleVisitViewModel.example()).environmentObject(EstatesViewModel.example())
        }
    }
}
