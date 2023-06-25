//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct CustomText: View {
    @Binding var text: String
    let placeholder: LocalizedStringKey

    var body: some View {
        TextField("", text: $text, prompt: {
            Text(placeholder)
                .foregroundColor(ColorPalette.secondary)
        }())
        .foregroundColor(ColorPalette.secondary)
    }
}

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
            Text("Mau").tag(Evaluation.bad)
            Text("Médio").tag(Evaluation.medium)
            Text("Bom").tag(Evaluation.good)
            Text("Muito Bom").tag(Evaluation.veryGood)
        }
        .pickerStyle(MenuPickerStyle())
        .accentColor(ColorPalette.secondary)
    }
}

struct VisitReportFormView: View {
    @State private var visitReport: VisitReport = VisitReport()
    
    func onAppear() {
        guard let uuidString = Auth.auth().currentUser?.uid  else {
            return
        }
        visitReport.userId = uuidString;
    }
    
    func save(visitReport: VisitReport) -> Void {
        let db = Firestore.firestore()
        let collectionRef = db.collection("VisitReport")
        do {
            try collectionRef.addDocument(from: visitReport) { error in
                if let error = error {
                    print("Error saving data: \(error.localizedDescription)")
                } else {
                    print("Data saved successfully!")
                }
            }
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            LogoView()
            Form {
                CustomSection(header: "client") {
                    CustomText(text:$visitReport.clientName, placeholder: "clientName")
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    
                    CustomText(text: $visitReport.listingCode, placeholder: "listingCodeWithExample"
                    )
                }
                
                CustomSection(header: "property") {
                    CustomPicker(selection: $visitReport.floorPlan, label: "floorPlan")
                    CustomPicker(selection: $visitReport.finishes, label: "finishes")
                    CustomPicker(selection: $visitReport.sunExposition, label: "sunExposure")
                    CustomPicker(selection: $visitReport.locationRating, label: "location")
                    CustomPicker(selection: $visitReport.value, label: "value")
                    CustomPicker(selection: $visitReport.overallAssessment, label: "overallAssessment")
                    CustomPicker(selection: $visitReport.agentService, label: "kwService")
                }
                
                CustomSection(header: "impressions") {
                    Picker(selection: $visitReport.isOption, label: Text("isThisPropertyAnOption")) {
                        Text("yes").tag(Decision.yes)
                        Text("no").tag(Decision.no)
                        Text("maybe").tag(Decision.maybe)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(ColorPalette.secondary)
                    
                    CustomText(text: $visitReport.dislikes, placeholder: "whatDidYouDislike")
                    CustomText(text: $visitReport.likes, placeholder: "whatDidYouLike")
                    Text("howMuchAreYouWillingToPay").foregroundColor(ColorPalette.secondary)
                    CustomText(text: $visitReport.willingToPay, placeholder: "moneyExample")
                }
                
                Section {
                    Button("submit") {
                        print("Form submitted with success!")
                        save(visitReport: visitReport)
                    }
                    .padding(.horizontal, 0.0)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .foregroundColor(.accentColor)
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .onAppear(perform: onAppear)
            .padding()
        }
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
