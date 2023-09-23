//
//  BidService.swift
//  Urban
//
//  Created by Juliana Estrela on 23/09/2023.
//

import Firebase
import FirebaseFirestore
import Foundation

class BidService {
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.bids)
    private let estateService: EstateService = .shared
    
    static let shared = BidService()
    private init(){}
    
    func save(_ bid: Bid) async -> DocumentReference? {
        do {
            let result = try collection.addDocument(from: bid)
            Logger.infoBidCreated()
            return result
        } catch {
            Logger.error(error)
            return nil
        }
    }
    
    func get(uuid: String) async -> [Bid] {
        do {
            let estate = estateService.convertToDocumentReference(uuid)
            let documents = try await collection.whereField("estate", isEqualTo: estate).getDocuments().documents
            
            let bids: [Bid] = documents.compactMap { document -> Bid? in
                do {
                    let bidDocument = try document.data(as: Bid.self)
                    return bidDocument
                } catch {
                    Logger.error(error)
                    return nil
                }
            }
            
            Logger.verboseFetchedEstates()
            return bids
        } catch {
            Logger.error(error)
            return []
        }
    }
}
