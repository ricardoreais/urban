//
//  VisitsObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import Firebase
import FirebaseFirestore
import Foundation

// TODO: Segregate service logic from viewmodel logic
class VisitObservable: ObservableObject {
    @Published var values: [Visit] = []
    @Published var isLoading = true
    private var user: UserObservable = .shared
    private var estateObs: EstateObservable = .shared
    
    static let shared = VisitObservable()
    private init() {}
    
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.visits)
    
    // Schedules a visit and associates it with the current agent.
    func create(_ command: CreateVisitCommand) async -> Bool {
        let currentUserReference = user.convertToDocumentReference(user.value.id!)
        let buyerReference = user.convertToDocumentReference(command.buyer.id!)
        let currentEstate = estateObs.convertToDocumentReference((estateObs.selected?.id)!)
        let visit = Visit(date: command.date, estate: currentEstate, buyer: buyerReference, agent: currentUserReference)
        
        do {
            _ = try collection.addDocument(from: visit)
            Logger.infoVisitCreated(command.date)
            return true
        } catch {
            Logger.error(error)
            return false
        }
    }
    
    // Gets the visits of the current buyer user.
    func get() async {
        do {
            let currentUserReference = user.convertToDocumentReference(user.value.id!)
            let documents = try await collection.whereField("buyer", isEqualTo: currentUserReference).getDocuments().documents
            let visits: [Visit] = documents.compactMap { document -> Visit? in
                do {
                    return try document.data(as: Visit.self)
                } catch {
                    Logger.error(error)
                    return nil
                }
            }
            
            DispatchQueue.main.async {
                Logger.verboseFetchedEstates()
                self.isLoading = false
                self.values = visits
            }
        } catch {
            Logger.error(error)
        }
    }
}
