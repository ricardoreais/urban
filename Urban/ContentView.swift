//
//  ContentView.swift
//  Urban
//
//  Created by Juliana Estrela on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var houseId: String = ""
    @State private var visitDate: Date = Date.now
    @State private var constructionQuality: Evaluation = Evaluation.medium
    @State private var finishes: Evaluation = Evaluation.medium
    @State private var solarExposition: Evaluation = Evaluation.medium
    @State private var location: Evaluation = Evaluation.medium
    @State private var price: Evaluation = Evaluation.medium
    @State private var value: Evaluation = Evaluation.medium
    @State private var globalAppreciation: Evaluation = Evaluation.medium
    @State private var userDecision: Decision = Decision.maybe
    @State private var dislikes: String = ""
    @State private var likes: String = ""
    @State private var willingToPay: String = ""
    @State private var finalEvaluation: Rating = Rating.threeStars
    
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
                            text: $username
                        )
                        .background(Color.clear)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField(
                        "Id da angariação e.g. 1208-3634",
                        text: $houseId
                    )
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Propriedade")) {
                    Picker(selection: $constructionQuality, label: Text("Qualidade de construção")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $finishes, label: Text("Acabamentos")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $solarExposition, label: Text("Exposição solar")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $location, label: Text("Localização")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $price, label: Text("Preço")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $value, label: Text("Valor")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                    Picker(selection: $globalAppreciation, label: Text("Apreciação global")) {
                        Text("Mau").tag(Evaluation.bad)
                        Text("Médio").tag(Evaluation.medium)
                        Text("Bom").tag(Evaluation.good)
                        Text("Muito Bom").tag(Evaluation.veryGood)
                    }
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("Impressões")) {
                    Picker(selection: $userDecision, label: Text("Compraria ou arrendaria?")) {
                        Text("Sim").tag(Decision.yes)
                        Text("Não").tag(Decision.no)
                        Text("Talvez").tag(Decision.maybe)
                    }
                    Text("O que gostou menos?")
                    TextEditor(text: $dislikes)
                    Text("O que gostou mais?")
                    TextEditor(text: $likes)
                    Text("Quanto estaria disposto a pagar por este imóvel?")
                    TextField("e.g. 200,000,00$", text: $willingToPay)
                    Picker(selection: $finalEvaluation, label: Text("Avaliação final da visita")) {
                            Text("⭐️").tag(Rating.oneStar)
                            Text("⭐️⭐️").tag(Rating.twoStars)
                            Text("⭐️⭐️⭐️").tag(Rating.threeStars)
                            Text("⭐️⭐️⭐️⭐️").tag(Rating.fourStars)
                            Text("⭐️⭐️⭐️⭐️⭐️").tag(Rating.fiveStars)
                    }
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Button("Submeter") {
                        print("Formulário submetido com sucesso!")
                    }
                    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color(hex: "C6C2B5", opacity: 0.3))
            }
            .foregroundColor(Color(hex: "514C4D"))
            .scrollContentBackground(.hidden)
        }
        .padding()
        .background(Color(hex: "EBE5D0"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
