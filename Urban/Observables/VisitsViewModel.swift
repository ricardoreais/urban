//
//  File.swift
//  Urban
//
//  Created by Juliana Estrela on 28/05/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class VisitsViewModel: ObservableObject {
    @Published var reports: [VisitReport] = []
    
    func fetchVisitReports() {
            let db = Firestore.firestore()
            db.collection("VisitReport").getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching visit reports: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                let reports: [VisitReport] = documents.compactMap { document -> VisitReport? in
                    do {
                        let report = try document.data(as: VisitReport.self)
                        print("Obtained document \(report.id) with success!")
                        return report
                    } catch {
                        print("Error decoding document: \(error.localizedDescription)")
                        print(String(describing: error))
                        return nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.reports = reports
                }
            }
        }
}
