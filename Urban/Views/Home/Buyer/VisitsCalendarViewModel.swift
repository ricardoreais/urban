//
//  VisitsObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//
import Foundation

class VisitsCalendarViewModel: ObservableObject {
    @Published var visits: [Visit] = []
    @Published var isLoading = true
    
    let visitService: VisitServiceProtocol
    
    static let shared = VisitsCalendarViewModel(visitService: VisitService())
    
    init(visitService: VisitServiceProtocol) {
        self.visitService = visitService
        
        Task{
            await get()
        }
    }
    
    func get() async {
        self.visits = await visitService.get()
        self.isLoading = false
    }
}
