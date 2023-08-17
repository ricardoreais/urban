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
    
    init(estateService: EstateServiceProtocol = EstateService()) {
        self.estateStore = EstatesStore(estateService: estateService)
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
                        NavigationLink(destination: EstateView()) {
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
        let estateStore: EstatesStore = EstatesStore(estateService: estateServiceMock)
        estateStore.selected = estateServiceMock.estate1
        let hasEstates: Bool = estateStore.selected == nil
        print("hello")
        //return Text("Has estates: \(hasEstates ? "yes" : "no")")
        return EstatesView(estateService: EstateServiceMock())
    }
}
