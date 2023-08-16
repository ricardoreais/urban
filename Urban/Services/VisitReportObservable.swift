//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisitReportObservable: ObservableObject {
    @Published var report: VisitReport = VisitReport()
    @Published var isLoading = true
    
    let visitReportService: VisitReportService
    static let shared = VisitReportObservable(visitReportService: VisitReportService())
    
    private init(visitReportService: VisitReportService) {
        self.visitReportService = visitReportService
    }
    
    func fetchVisitReport(id: String) {
        visitReportService.get(id: id) { result in
            switch result {
                case .success(let report):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.report = report
                    }
                case .failure(let error):
                    print("Error fetching visit report: \(error.localizedDescription)")
            }
        }
    }
}
