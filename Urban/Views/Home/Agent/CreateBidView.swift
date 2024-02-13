//
//  CreateBidView.swift
//  Urban
//
//  Created by Juliana Estrela on 13/02/2024.
//

import SwiftUI

struct CreateBidView: View {
    @State private var bid: Bid
    let bidService: BidService = .shared
    
    public init() {
        self.bid = .init(status: .draft)
    }
    func save() async -> Void {
        //bid.buyer = TODO
        //bid.estate = TODO
        
        await bidService.save(bid)
    }
    
    var body: some View {
        CustomBackground {
            Logo()
            CustomForm {
                CustomSection(header: "bid") {
                    CustomDecimalInput(value: $bid.value, placeholder: "yourBidValue")
                }
                
                Section {
                    CustomButton("submit", asyncAction: save)
                        .foregroundColor(.accentColor)
                        .listRowBackground(Color.clear)
                }
            }
        }
    }
}

#Preview {
    CreateBidView()
}
