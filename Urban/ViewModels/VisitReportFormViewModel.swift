//
//  VisitReportFormViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 27/09/2023.
//


import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class VisitReportFormViewModel: ObservableObject {
    @Published var visitReport: VisitReport = .init()
    @Published var bid: Bid = .init(status: .draft)
    @Published var bidCreated: Bool = false
    @Published var visitReportCreated: Bool = false
    @Published var navigate: Bool = false
    @Published var hasErrors: Bool = false
    @Published var showAlert: Bool = false
    
    let visitReportService: VisitReportService = .shared
    let bidService: BidService = .shared
    
    static let shared = VisitReportFormViewModel()
    private init() {}
    
    func save() async {
        do {
            try await visitReportService.save(visitReport: visitReport)
            
            visitReportCreated = true
            
            var bidReference: DocumentReference? = nil
            
            if bid.value?.isNormal ?? false {
                bidReference = await bidService.save(bid)
                bidCreated = bidReference != nil
            }
        } catch VisitReportError.missingRequiredFields {
            hasErrors = true
        } catch VisitReportError.saveFailed(_) {
            hasErrors = true
        } catch {
            // Handle any other errors
            hasErrors = true
        }
        
        showAlert = true
    }
}
