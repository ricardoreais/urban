//
//  ScheduleVisitViewModel.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation

@MainActor
class ScheduleVisitViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var buyers: [User] = []
    
    let userService: UserService = .shared
    let visitService: VisitService = .shared
    
    static let shared = ScheduleVisitViewModel()
    private init() {
        Task {
            await get()
        }
    }
    
    func get() async -> Void {
        Task {
            do {
                self.buyers = try await userService.get(.buyer)
                self.isLoading = false
            } catch {
                // Handle fetching users by type errors
            }
        }
    }
    
    func createVisit(estate: Estate, date: Date, buyer: User) async -> Bool {
        let createVisitCommand = CreateVisitCommand(date: date, buyer: buyer, estate: estate)
        return await visitService.create(createVisitCommand)
    }
    
    static func example() -> ScheduleVisitViewModel {
        let scheduleVisitViewModel = ScheduleVisitViewModel()
        scheduleVisitViewModel.buyers = [User.BuyerExample()]
        scheduleVisitViewModel.isLoading = false
        return scheduleVisitViewModel
    }
}
