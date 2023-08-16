//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import Firebase
import FirebaseFirestore
import SwiftUI

struct VisitReportFormView: View {
    @State private var visitReport: VisitReport = .init()
    @State private var visitCreated: Bool = false
    @State private var hasErrors: Bool = false
    
    func save(visitReport: VisitReport) {
        hasErrors = visitReport.agent == nil || visitReport.buyer == nil
        
        if hasErrors {
            return
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("VisitReports")
        do {
            try collectionRef.addDocument(from: visitReport) { error in
                if let error = error {
                    hasErrors = true
                    print("Error saving data: \(error.localizedDescription)")
                } else {
                    print("Form submitted with success!")
                    visitCreated = true
                }
            }
        } catch {
            hasErrors = true
            print("Error saving data: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            CustomBackground {
                Logo()
                CustomForm {
                    CustomSection(header: "property") {
                        EvaluationPicker(selection: $visitReport.floorPlan, label: "floorPlan")
                        EvaluationPicker(selection: $visitReport.finishes, label: "finishes")
                        EvaluationPicker(selection: $visitReport.sunExposition, label: "sunExposure")
                        EvaluationPicker(selection: $visitReport.locationRating, label: "location")
                        EvaluationPicker(selection: $visitReport.value, label: "value")
                        EvaluationPicker(selection: $visitReport.overallAssessment, label: "overallAssessment")
                        EvaluationPicker(selection: $visitReport.agentService, label: "kwService")
                    }
                    
                    CustomSection(header: "impressions") {
                        CustomInput(text: $visitReport.likes, placeholder: "whatDidYouLike")
                        
                        CustomInput(text: $visitReport.dislikes, placeholder: "whatDidYouDislike")
                        
                        Text("howMuchAreYouWillingToPay").foregroundColor(ColorPalette.secondary)
                        CustomInput(text: $visitReport.willingToPay, placeholder: "moneyExample")
                        
                        CustomPicker(selection: $visitReport.isOption, label: "isThisPropertyAnOption", options: [Decision.yes, Decision.no])
                        
                        CustomPicker(selection: $visitReport.hasPropertyToSell, label: "doYouHaveAnyPropertyToSell", options: [Decision.yes, Decision.no])
                        
                        CustomInput(text: $visitReport.comments, placeholder: "comments")
                    }
                    Section {
                        Button("submit") {
                            save(visitReport: visitReport)
                        }
                        .navigationDestination(isPresented: $visitCreated) {
                            HomeView()
                        }
                        .padding(.horizontal, 0.0)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .foregroundColor(.accentColor)
                    .listRowBackground(Color.clear)
                }
                .alert(isPresented: $hasErrors) {
                    Alert(
                        title: Text("error"),
                        message: Text("pleaseFillFieldsCorrectly"),
                        dismissButton: .default(Text("ok"))
                    )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportFormView()
    }
}
