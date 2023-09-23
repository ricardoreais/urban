//
//  VisitsViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

@MainActor
class VisitReportsViewModel: ObservableObject {
    @Published var reports: [VisitReport] = []
    @Published var selected: VisitReport = VisitReport()
    @Published var isLoading = true
    let visitReportService: VisitReportService = .shared
    let estateService: EstateService = .shared
    
    static let shared = VisitReportsViewModel()
    private init() {}
    
    func setSelectedReport(_ selectedReport: VisitReport){
        self.selected = selectedReport
    }	
    
    func load() async throws -> Void {
        if(isLoading){
            self.reports = try await visitReportService.get()
//            for report in reports {
//                if let estateReference = report.estate {
//                    Task {
//                        if let estate = await estateService.get(estateReference) {
//                            report.estateValue = estate
//                        }
//                    }
//                }
//            }
        }
        isLoading = false
    }
    
    static func example() -> VisitReportsViewModel {
        let visitReportsViewModel = VisitReportsViewModel()
        visitReportsViewModel.reports = [VisitReport.Example()]
        visitReportsViewModel.isLoading = false
        visitReportsViewModel.selected = VisitReport.Example()
        return visitReportsViewModel
    }
}
