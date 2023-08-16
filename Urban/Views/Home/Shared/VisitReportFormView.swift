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
    @State private var created: Bool = false
    @State private var hasErrors: Bool = false
    
    let visitReportService: VisitReportService
    
    init(visitReportService: VisitReportService = VisitReportService()) {
        self.visitReportService = visitReportService
    }
    
    func save(visitReport: VisitReport) async {
        do {
            try await visitReportService.save(visitReport: visitReport)
            print("Form submitted with success!")
            created = true
        } catch VisitReportError.missingRequiredFields {
            hasErrors = true
        } catch let VisitReportError.saveFailed(error) {
            hasErrors = true
            print("Error saving data: \(error)")
        } catch {
            // Handle any other errors
            hasErrors = true
            print("Unknown error: \(error)")
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
                        CustomButton("submit", asyncAction: { await save(visitReport: visitReport) })
                            .navigationDestination(isPresented: $created) {
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
