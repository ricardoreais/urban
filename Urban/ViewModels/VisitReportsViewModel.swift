//
//  VisitsViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

class VisitReportsViewModel: ObservableObject {
    @Published var reports: [VisitReport] = []
    @Published var selected: VisitReport = VisitReport()
    @Published var isLoading = true
    
    let visitReportService: VisitReportService = .shared
    
    static let shared = VisitReportsViewModel()
    
    init() {
        Task {
            if(isLoading){
                reports = try await visitReportService.get()
            }
            isLoading = false
        }
    }
    
    func setSelectedReport(_ selectedReport: VisitReport){
        self.selected = selectedReport
    }
}
