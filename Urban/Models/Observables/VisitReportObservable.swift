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
    
    func fetchVisitReport(id: String) {
        print("Getting visit: \(id)")
        let db = Firestore.firestore()
        db.collection("VisitReports")
            .document(id)
            .getDocument { snapshot, error in
               if let error = error {
                   print("Error fetching visit report: \(error.localizedDescription)")
                   return
               }
               
               guard let documentData = snapshot?.data() else {
                   print("Visit report not found")
                   return
               }
               
               do {
                   let report = try Firestore.Decoder().decode(VisitReport.self, from: documentData)
                   print("Obtained document \(report.id) with success!")
                   DispatchQueue.main.async {
                       self.isLoading = false
                       self.report = report
                   }
               } catch {
                   print("Error decoding document: \(error.localizedDescription)")
               }
           }
    }
}
