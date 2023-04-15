//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var visitReport: VisitReport = VisitReport()
    
    func save(visitReport: VisitReport) -> Void {
        let db = Firestore.firestore()
        let collectionRef = db.collection("VisitReport")
        let data = convertvisitReportToDictionary(visitReport: visitReport)
        collectionRef.addDocument(data: data) { error in
            if let error = error {
                print("Error saving data: \(error.localizedDescription)")
            } else {
                print("Data saved successfully!")
            }
        }
    }

    func convertvisitReportToDictionary(visitReport: VisitReport) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        let mirror = Mirror(reflecting: visitReport)
        
        for case let (label?, value) in mirror.children {
            dictionary[label] = String(describing: value)
        }
        
        return dictionary
    }
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Form {
                Section(header: Text("Cliente")) {
                    TextField(
                            "Nome do cliente",
                            text: $visitReport.clientName
                        )
                        .background(Color.clear)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField(
                        "Id da angariação e.g. 1208-3634",
                        text: $visitReport.listingCode
                    )
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Propriedade")) {
                    Picker(selection: $visitReport.floorPlan, label: Text("Planta do Imóvel")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.finishes, label: Text("Acabamentos")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.sunExposition, label: Text("Exposição solar")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.locationRating, label: Text("Localização")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.locationRating, label: Text("Preço")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.value, label: Text("Valor")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.overallAssessment, label: Text("Apreciação global")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $visitReport.agentService, label: Text("Serviço KW")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Impressões")) {
                    Picker(selection: $visitReport.isOption, label: Text("Este imóvel seria uma opção?")) {
                        Text("Sim").tag(Decision.yes)
                        Text("Não").tag(Decision.no)
                        Text("Talvez").tag(Decision.maybe)
                    }
                    Text("O que gostou menos?")
                    TextEditor(text: $visitReport.dislikes)
                    Text("O que gostou mais?")
                    TextEditor(text: $visitReport.likes)
                    Text("Quanto estaria disposto a pagar por este imóvel?")
                    TextField("e.g. 200,000,00$", text: $visitReport.willingToPay)
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Button("Submeter") {
                        print("Formulário submetido com sucesso!")
                        save(visitReport: visitReport)
                    }
                    .padding(.horizontal, 0.0)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color(hex: "C6C2B5", opacity: 0.3))
            }
            .foregroundColor(Color(hex: "514C4D"))
            .scrollContentBackground(.hidden)
        }
        .padding()
        .background(Color(hex: "EBE2D0"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
