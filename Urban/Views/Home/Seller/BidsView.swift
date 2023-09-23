//
//  BidsView.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import SwiftUI

struct BidsView: View {
    @ObservedObject var model: BidsViewModel = .shared
    let estate: Estate
    
    var body: some View {
        CustomBackground {
            if model.isLoading {
                CustomLoading()
            } else {
                if(model.bids.isEmpty){
                    Text("noBidsYet")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                    List(model.bids) { bid in
                        if let bidValue = bid.value {
                            CustomText(label: "bidValue", value: String(describing: bidValue)) + CustomText(label: "buyer", value: bid.buyerValue?.email)
                        } else {
                            // Handle the case where bid.value is nil
                            Text("Bid value is not available")
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await self.model.get(uuid: estate.id!)
            }
        }
    }
}

struct BidsView_Previews: PreviewProvider {
    static var previews: some View {
        BidsView(model: BidsViewModel.example(), estate: Estate.Example())
    }
}
