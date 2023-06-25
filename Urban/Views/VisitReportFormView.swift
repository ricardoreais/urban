//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .foregroundColor(.purple) // Modify the label color
    }
}

struct CustomPicker: View {
    public var selection: Binding<Evaluation>
    public var label: String
    
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
                Section(header: Text("Cliente")) {
                    TextField(
                        "",
                        text: $visitReport.clientName,
                        prompt: Text("Nome do cliente").foregroundColor(ColorPalette.secondary)
                    )
                    .foregroundColor(ColorPalette.secondary)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    TextField(
                        "",
                        text: $visitReport.listingCode,
                        prompt: Text("Id da angariação e.g. 1208-3634").foregroundColor(ColorPalette.secondary)
                    )
                    .foregroundColor(ColorPalette.secondary)
                }
                .foregroundColor(.accentColor)
                .listRowBackground(Color.clear)
                
                Section(header: Text("Propriedade")) {
                    CustomPicker(selection: $visitReport.floorPlan, label: "Planta do Imóvel")
                    CustomPicker(selection: $visitReport.finishes, label: "Acabamentos")
                    CustomPicker(selection: $visitReport.sunExposition, label: "Exposição solar")
                    CustomPicker(selection: $visitReport.locationRating, label: "Localização")
                    CustomPicker(selection: $visitReport.value, label: "Valor")
                    CustomPicker(selection: $visitReport.overallAssessment, label: "Apreciação global")
                    CustomPicker(selection: $visitReport.agentService, label: "Serviço KW")
                }
                .foregroundColor(.accentColor)
                .listRowBackground(Color.clear)
                
                Section(header: Text("Impressões")) {
                    Picker(selection: $visitReport.isOption, label: Text("Este imóvel seria uma opção?")) {
                        Text("Sim").tag(Decision.yes)
                        Text("Não").tag(Decision.no)
                        Text("Talvez").tag(Decision.maybe)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(ColorPalette.secondary)
                    TextField(
                        "",
                        text: $visitReport.dislikes,
                        prompt: Text("O que gostou menos?").foregroundColor(ColorPalette.secondary)
                    )
                    .foregroundColor(ColorPalette.secondary)
                    TextField(
                        "",
                        text: $visitReport.likes,
                        prompt: Text("O que gostou mais?").foregroundColor(ColorPalette.secondary)
                    )
                    .foregroundColor(ColorPalette.secondary)
                    Text("Quanto estaria disposto a pagar por este imóvel?").foregroundColor(ColorPalette.secondary)
                    TextField("", text: $visitReport.willingToPay,
                              prompt: Text("e.g. 200,000,00$").foregroundColor(ColorPalette.secondary))
                    .foregroundColor(ColorPalette.secondary)
                }
                .foregroundColor(.accentColor)
                .listRowBackground(Color.clear)
                
                Section {
                    Button("Submeter") {
                        print("Formulário submetido com sucesso!")
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
        .accentColor(.accentColor)
        .background(ColorPalette.primary)
    }
}

struct VisitFormView_Previews: PreviewProvider {
    static var previews: some View {
        VisitReportFormView()
    }
}
