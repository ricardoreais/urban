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
    @ObservedObject var estateStore: EstatesStore
    
    init(estatesStore: EstatesStore = .shared) {
        self.estateStore = estatesStore
    }

    var body: some View {
        CustomBackground {
            if estateStore.isLoading {
                CustomLoading()
            } else {
                if estateStore.estates.isEmpty {
                    Text("noEstatesYet")
                } else {
                    List(estateStore.estates) { estate in
                        NavigationLink(destination: EstateView(estateStore: estateStore)) {
                            CustomText(label: "code", value: estate.code) +
                                CustomText(label: "address", value: estate.address)
                        }.simultaneousGesture(TapGesture().onEnded{
                            estateStore.setSelected(estate)
                        })
                        .listRowBackground(ColorPalette.highlights)
                    }
                }
            }
        }
    }
}

struct EstatesView_Previews: PreviewProvider {
    static var previews: some View {
        let estateServiceMock = EstateServiceMock()
        let estatesStore: EstatesStore = EstatesStore(estateService: estateServiceMock)
        estatesStore.selected = estateServiceMock.estate1
        return NavigationView{EstatesView(estatesStore: estatesStore)}
    }
}
