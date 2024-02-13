//
//  VisitsObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//
import Foundation

@MainActor
class VisitsCalendarViewModel: ObservableObject {
    @Published var visits: [Visit] = []
    @Published var isLoading = false // Initialize as false
    let visitService: VisitService = .shared
    
    static let shared = VisitsCalendarViewModel()
    private init() {}
    
    func loadVisits() async {
        isLoading = true // Set isLoading to true when loading data
        visits = await visitService.get()
        isLoading = false // Set isLoading to false after data is loaded successfully
    }
    
    static func example() -> VisitsCalendarViewModel {
        let visitsCalendarViewModel = VisitsCalendarViewModel()
        visitsCalendarViewModel.visits = [Visit.Example()]
        visitsCalendarViewModel.isLoading = false
        return visitsCalendarViewModel
    }
}
