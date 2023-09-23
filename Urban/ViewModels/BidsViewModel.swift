//
//  BidsViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import Foundation

@MainActor
class BidsViewModel: ObservableObject {
    @Published var bids: [Bid] = []
    @Published var isLoading = false
    let bidService: BidService = .shared
    let userService: UserService = .shared
    
    static let shared = BidsViewModel()
    private init() {}
    
    func get(uuid: String) async {
        if self.bids.isEmpty {
            self.isLoading = true
            
            
            var loadedBids: [Bid] = []
            loadedBids = await self.bidService.get(uuid: uuid)
            
            for i in loadedBids.indices {
                loadedBids[i].buyerValue = await userService.getByReference(loadedBids[i].buyer!)
            }
            
            self.bids = loadedBids
            self.isLoading = false
        }
    }
    
    static func example() -> BidsViewModel {
        let bidsViewModel = BidsViewModel()
        bidsViewModel.bids = [Bid.Example()]
        return bidsViewModel
    }
}
