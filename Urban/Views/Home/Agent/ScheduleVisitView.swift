//
//  ScheduleVisitView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

struct ScheduleVisitView: View {
    @ObservedObject var userObs: UserObservable = .shared
    @ObservedObject private var visitObs: VisitObservable = .shared

    @State private var selectedDate = Date()
    @State private var selectedAgents: Set<User> = Set([])
    @State private var created: Bool = false
    @State private var hasError: Bool = false

    func createVisit() async {
        let createVisitCommand = CreateVisitCommand(date: selectedDate, buyer: selectedAgents.first!)
        created = await visitObs.create(createVisitCommand)
        hasError = !created
    }

    var body: some View {
        CustomBackground {
            CustomForm {
                CustomSection(header: "estate") {
                    CustomDatePicker(selectedDate: $selectedDate)
                    CustomSelectList<User>(
                        label: "buyers",
                        options: userObs.users,
                        optionToString: { $0.email! },
                        selected: $selectedAgents
                    )
                    .onAppear(perform: {
                        userObs.get(type: .buyer)
                    })
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
        let user = UserObservable.shared
        user.isLoading = false
        user.value = User(
            id: "user123",
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()),
            name: "John Doe",
            email: "john@example.com",
            telephone: "123-456-7890",
            types: [.seller, .buyer]
        )
        return NavigationView {
            ScheduleVisitView(userObs: user)
        }
    }
}
