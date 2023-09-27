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

    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "€" // Set your desired currency symbol here
        return formatter
    }()
    
    var body: some View {
        CustomBackground {
            if model.isLoading {
                CustomLoading()
            } else {
                Logo()
                if model.bids.isEmpty {
                    Text("noBidsYet")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(model.bids) { bid in
                        if let bidValue = bid.value {
                            Group {
                                CustomText(label: "buyer", value: bid.buyerValue?.email) + CustomText(label: "bidValue", value: currencyFormatter.string(from: bidValue as NSNumber) ?? "")
                            }.listRowBackground(ColorPalette.highlights)
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
