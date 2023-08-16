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
    @ObservedObject var model: EstatesViewModel
    
    init(model: EstatesViewModel = .shared) {
        self.model = model
    }

    var body: some View {
        CustomBackground {
            if model.isLoading {
                CustomLoading()
            } else {
                if model.estates.isEmpty {
                    Text("noEstatesYet")
                } else {
                    List(model.estates) { estate in
                        NavigationLink(destination: EstateView(estate: estate)) {
                            CustomText(label: "code", value: estate.code) +
                                CustomText(label: "address", value: estate.address)
                        }
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
    }
}

struct EstatesView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView { EstatesView(model: EstatesViewModel(estateService: EstateServiceMock())) }
    }
}
