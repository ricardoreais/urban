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
    let visitService: VisitServiceProtocol
    @ObservedObject var estatesStore: EstatesStore

    @State private var selectedDate = Date()
    @State private var selectedAgents: Set<User> = Set([])
    @State private var created: Bool = false
    @State private var hasError: Bool = false

    init(userService: UserServiceProtocol = UserService(), visitService: VisitServiceProtocol = VisitService(), estatesStore: EstatesStore) {
        self.model = ScheduleVisitViewModel(userService: userService)
        self.visitService = visitService
        self.estatesStore = estatesStore
    }

    func createVisit() async {
        let createVisitCommand = CreateVisitCommand(date: selectedDate, buyer: selectedAgents.first!, estate: estatesStore.selected!)
        created = await visitService.create(createVisitCommand)
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
        let userService: UserServiceMock = UserServiceMock()
        let model = ScheduleVisitViewModel.shared
        model.isLoading = false
        model.buyers = [userService.buyer]
        return NavigationView {
            ScheduleVisitView(userService: UserServiceMock(), visitService: VisitServiceMock(), estatesStore: EstatesStore(estateService: EstateServiceMock()))
        }
    }
}
