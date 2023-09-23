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
    let visitService: VisitService = .shared
    
    static let shared = VisitsCalendarViewModel()
    
    private init() {
        Task{
            await get()
        }
    }
    
    func get() async {
        self.visits = await visitService.get()
        self.isLoading = false
    }
    
    static func example() -> VisitsCalendarViewModel {
        let visitsCalendarViewModel = VisitsCalendarViewModel()
        visitsCalendarViewModel.visits = [Visit.Example()]
        visitsCalendarViewModel.isLoading = false
        return visitsCalendarViewModel
    }
}
