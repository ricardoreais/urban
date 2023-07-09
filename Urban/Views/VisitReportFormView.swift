//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CustomSection<Content: View>: View {
    let header: String
    let content: Content
    
    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        Section(header: Text(LocalizedStringKey(header))) {
            content
        }
        .foregroundColor(.accentColor)
        .listRowBackground(Color.clear)
    }
}

struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .foregroundColor(.purple) // Modify the label color
    }
}

struct CustomPicker: View {
    public var selection: Binding<Evaluation>
    public var label: LocalizedStringKey
    
    var body: some View {
        Picker(selection: selection, label: Text(label)) {
            Text(Evaluation.bad.rawValue).tag(Evaluation.bad)
            Text(Evaluation.medium.rawValue).tag(Evaluation.medium)
            Text(Evaluation.good.rawValue).tag(Evaluation.good)
            Text(Evaluation.veryGood.rawValue).tag(Evaluation.veryGood)
        }
        .pickerStyle(MenuPickerStyle())
        .accentColor(ColorPalette.secondary)
    }
}

struct VisitReportFormView: View {
    @State private var visitReport: VisitReport = VisitReport()
    @State private var visitCreated: Bool = false
    @State private var hasErrors: Bool = false
    
    func onAppear() {
        guard let uuidString = Auth.auth().currentUser?.uid  else {
            return
        }
        visitReport.userId = uuidString;
    }
    
    func save(visitReport: VisitReport) -> Void {
        hasErrors = visitReport.clientName.isEmpty || visitReport.listingCode.isEmpty
        
        if(hasErrors){
            return
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("VisitReport")
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
        } catch let error {
            hasErrors = true
            print("Error saving data: \(error)")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Logo()
                Form {
                    CustomSection(header: "client") {
                        CustomInput(text:$visitReport.clientName, placeholder: "clientName")
                            .textInputAutocapitalization(.words)
                            .disableAutocorrection(true)
                        
                        CustomInput(text: $visitReport.listingCode, placeholder: "listingCodeWithExample"
                        )
                    }
                    
                    CustomSection(header: "property") {
                        Group{
                            CustomInput(text: $visitReport.location, placeholder: "location")
                            CustomInput(text: $visitReport.listedValue, placeholder: "value")
                            CustomInput(text: $visitReport.address, placeholder: "address")
                            CustomInput(text: $visitReport.district, placeholder: "district")
                            
                        }
                        CustomPicker(selection: $visitReport.floorPlan, label: "floorPlan")
                        CustomPicker(selection: $visitReport.finishes, label: "finishes")
                        CustomPicker(selection: $visitReport.sunExposition, label: "sunExposure")
                        CustomPicker(selection: $visitReport.locationRating, label: "location")
                        CustomPicker(selection: $visitReport.value, label: "value")
                        CustomPicker(selection: $visitReport.overallAssessment, label: "overallAssessment")
                        CustomPicker(selection: $visitReport.agentService, label: "kwService")
                    }
                    
                    CustomSection(header: "impressions") {
                        CustomInput(text: $visitReport.likes, placeholder: "whatDidYouLike")
                        CustomInput(text: $visitReport.dislikes, placeholder: "whatDidYouDislike")
                        
                        Text("howMuchAreYouWillingToPay").foregroundColor(ColorPalette.secondary)
                        CustomInput(text: $visitReport.willingToPay, placeholder: "moneyExample")
                        
                        
                        Picker(selection: $visitReport.isOption, label: Text("isThisPropertyAnOption")) {
                            Text(Decision.yes.rawValue).tag(Decision.yes)
                            Text(Decision.no.rawValue).tag(Decision.no)
                            Text(Decision.maybe.rawValue).tag(Decision.maybe)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(ColorPalette.secondary)
                        
                        Picker(selection: $visitReport.hasPropertyToSell, label: Text("doYouHaveAnyPropertyToSell")) {
                            Text(Decision.yes.rawValue).tag(Decision.yes)
                            Text(Decision.no.rawValue).tag(Decision.no)
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(ColorPalette.secondary)
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
                .scrollContentBackground(.hidden)
                .onAppear(perform: onAppear)
                .padding()
            }
            .background(ColorPalette.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden(true)
        .accentColor(.accentColor)
        .background(ColorPalette.primary)
    }
}

struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportFormView()
    }
}
