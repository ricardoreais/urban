//
//  EstatesView.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import SwiftUI

struct EstatesView: View {
    @ObservedObject var estateObs = EstateObservable()

    var body: some View {
        CustomBackground {
            Text("Features: link para o site, morada")

            List(estateObs.values) { estate in
                NavigationLink(destination: VisitDetailsView(id: estate.id ?? "")) {
                    CustomText(label: "clientName", value: estate.code) +
                        CustomText(label: "address", value: estate.address)
                }
                .listRowBackground(ColorPalette.highlights)
            }
        }.onAppear {
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
        let estate = EstateObservable()
        let estate1 = Estate(code: "E001", address: "123 Main St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estate2 = Estate(code: "E002", address: "456 Elm St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estate3 = Estate(code: "E003", address: "789 Oak St", seller: nil, agents: nil, visits: nil, bids: nil)
        let estates: [Estate] = [estate1, estate2, estate3]
        estate.isLoading = false
        estate.values = estates
        return EstatesView(estateObs: estate)
    }
}
