//
//  VisitsViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class VisitsViewModel: ObservableObject {
    @Published var reports: [VisitReport] = []
    @Published var selected: VisitReport = VisitReport()
    @Published var isLoading = true
    
    let visitReportService: VisitReportService
    
    static let shared = VisitsViewModel()
    
    private init(visitReportService: VisitReportService = VisitReportService()) {
        self.visitReportService = visitReportService
        
        Task{
            try await visitReportService.get()
        }
    }
    
    func setSelectedReport(_ selectedReport: VisitReport){
        self.selected = selectedReport
    }
}
