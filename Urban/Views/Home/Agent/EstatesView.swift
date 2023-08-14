//
//  EstatesView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import FirebaseFirestore
import SwiftUI

// TODO: Features: visitas efetuadas, outros agentes, propostas criadas, criar proposta, criar ficha de visita
struct EstatesView: View {
    @ObservedObject private var userObs: UserObservable = .shared
    @ObservedObject var estateObs: EstateObservable = .shared
    @ObservedObject private var visitObs: VisitObservable = .shared

    var body: some View {
        CustomBackground {
            if estateObs.isLoading {
                CustomLoading()
            } else {
                if estateObs.values.isEmpty {
                    Text("noEstatesYet")
                } else {
                    List(estateObs.values) { estate in
                        NavigationLink(destination: EstateView(estate: estate)) {
                            CustomText(label: "code", value: estate.code) +
                                CustomText(label: "address", value: estate.address)
                        }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
        .onAppear {
            Task {
                if estateObs.values.isEmpty {
                    await estateObs.get()
                }
            }
        }
    }
}

struct EstatesView_Previews: PreviewProvider {
    static var previews: some View {
        let estate = EstateObservable.shared
        let estate1 = Estate(
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()), code: "E001", address: "123 Main St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estate2 = Estate(
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()), code: "E002", address: "456 Elm St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estate3 = Estate(
            createdAt: Timestamp(date: Date()),
            updatedAt: Timestamp(date: Date()), code: "E003", address: "789 Oak St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estates: [Estate] = [estate1, estate2, estate3]
        estate.isLoading = false
        estate.values = estates
        return NavigationView { EstatesView(estateObs: estate) }
    }
}
