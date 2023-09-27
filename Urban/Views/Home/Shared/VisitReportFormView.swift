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
    @ObservedObject var model: VisitReportFormViewModel = .shared
    
    let visit: Visit
    
    var body: some View {
        CustomBackground {
            Logo()
            CustomForm {
                CustomSection(header: "property") {
                    EvaluationPicker(selection: $model.visitReport.floorPlan, label: "floorPlan")
                    EvaluationPicker(selection: $model.visitReport.finishes, label: "finishes")
                    EvaluationPicker(selection: $model.visitReport.sunExposition, label: "sunExposure")
                    EvaluationPicker(selection: $model.visitReport.locationRating, label: "location")
                    EvaluationPicker(selection: $model.visitReport.value, label: "value")
                    EvaluationPicker(selection: $model.visitReport.overallAssessment, label: "overallAssessment")
                    EvaluationPicker(selection: $model.visitReport.agentService, label: "kwService")
                }
                CustomSection(header: "impressions") {
                    CustomInput(text: $model.visitReport.likes, placeholder: "whatDidYouLike")
                    CustomInput(text: $model.visitReport.dislikes, placeholder: "whatDidYouDislike")
                    CustomInput(text: $model.visitReport.willingToPay, placeholder: "howMuchAreYouWillingToPay")
                    CustomPicker(selection: $model.visitReport.isOption, label: "isThisPropertyAnOption", options: [Decision.yes, Decision.no])
                    CustomPicker(selection: $model.visitReport.hasPropertyToSell, label: "doYouHaveAnyPropertyToSell", options: [Decision.yes, Decision.no])
                        
                    CustomInput(text: $model.visitReport.comments, placeholder: "comments")
                }
                CustomSection(header: "bid") {
                    CustomDecimalInput(value: $model.bid.value, placeholder: "yourBidValue")
                }
                
                Section {
                    CustomButton("submit", asyncAction: model.save)
                        .alert(isPresented: $model.showAlert) {
                            if model.hasErrors {
                                return Alert(
                                    title: Text("error"),
                                    message: Text("pleaseFillFieldsCorrectly"),
                                    dismissButton: .default(Text("ok"))
                                )
                            } else {
                                return Alert(
                                    title: Text("success"),
                                    message: model.bidCreated ? Text("visitReportFormAndBidCreatedWithSuccess") : Text("visitReportFormCreatedWithSuccess"),
                                    dismissButton: .default(Text("ok"), action: { model.navigate = true })
                                )
                            }
                        }
                        .navigationDestination(isPresented: $model.navigate) {
                            HomeView()
                        }
                        .padding(.horizontal, 0.0)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .foregroundColor(.accentColor)
                .listRowBackground(Color.clear)
            }
        }
        .onAppear {
            self.model.bid.buyer = visit.buyer
            self.model.bid.estate = visit.estate
            
            self.model.visitReport.buyer = visit.buyer
            self.model.visitReport.agent = visit.agent
            self.model.visitReport.estate = visit.estate
        }
    }
}

struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportFormView(visit: Visit.Example())
    }
}
