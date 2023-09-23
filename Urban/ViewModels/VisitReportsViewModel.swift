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
    @Published var isLoading = false
    let visitReportService: VisitReportService = .shared
    let estateService: EstateService = .shared
    
    static let shared = VisitReportsViewModel()
    private init() {}
    
    func setSelectedReport(_ selectedReport: VisitReport){
        self.selected = selectedReport
    }	
    
    func load() async throws -> Void {
        isLoading = true;
        if(self.reports.isEmpty){
            var loadedReports: [VisitReport] = []
            loadedReports = try await visitReportService.get()
            
            for i in loadedReports.indices {
                loadedReports[i].estateValue = await estateService.get(loadedReports[i].estate!)
            }
            
            self.reports = loadedReports
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
