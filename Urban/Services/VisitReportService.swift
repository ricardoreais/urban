//
//  VisitReportService.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

class VisitReportService {
    static let shared = VisitReportService()
    private let db = Firestore.firestore()
    private let collection: CollectionReference = Firestore.firestore().collection(Collection.visitReports)
    
    func get(id: String, completion: @escaping (Result<VisitReport, Error>) -> Void) {
        collection
            .document(id)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documentData = snapshot?.data() else {
                    completion(.failure(NSError(domain: "Visit report not found", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let report = try Firestore.Decoder().decode(VisitReport.self, from: documentData)
                    completion(.success(report))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func getAll(forUserID userID: String, completion: @escaping (Result<[VisitReport], Error>) -> Void) {
        collection
            .whereField("userId", isEqualTo: userID)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.failure(NSError(domain: "No documents found", code: -1, userInfo: nil)))
                    return
                }
                
                let reports: [VisitReport] = documents.compactMap { document -> VisitReport? in
                    do {
                        let report = try document.data(as: VisitReport.self)
                        return report
                    } catch {
                        return nil
                    }
                }
                
                completion(.success(reports))
            }
    }
    
    func save(visitReport: VisitReport, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try collection.addDocument(from: visitReport) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
