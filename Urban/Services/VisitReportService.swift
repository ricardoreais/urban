//
//  VisitReportService.swift
//  Urban
//
//  Created by Juliana Estrela on 16/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol VisitReportServiceProtocol {
    func get(id: String, completion: @escaping (Result<VisitReport, Error>) -> Void)
    func get() async throws -> [VisitReport]
    func save(visitReport: VisitReport) async throws
}

class VisitReportService : VisitReportServiceProtocol {
    private let collection: CollectionReference
    private let userService: UserServiceProtocol
    private let userManager: UserManager
    
    init(userManager: UserManager = .shared, userService: UserServiceProtocol = UserService()) {
        self.collection = Firestore.firestore().collection(Collection.visitReports)
        self.userService = userService
        self.userManager = userManager
    }
    
    
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
    
    func get() async throws -> [VisitReport] {
        do {
            let query = collection.whereField("buyer", isEqualTo: userService.convertToDocumentReference(userManager.current.id!))
            let querySnapshot = try await query.getDocuments()
            
            return querySnapshot.documents.compactMap { document in
                do {
                    return try document.data(as: VisitReport.self)
                } catch {
                    // Handle any errors related to data decoding
                    print("Error decoding document: \(error)")
                    return nil
                }
            }
        } catch {
            throw error
        }
    }
    
    func save(visitReport: VisitReport) async throws {
        guard visitReport.agent != nil, visitReport.buyer != nil else {
            throw VisitReportError.missingRequiredFields
        }
        
        do {
            _ = try collection.addDocument(from: visitReport)
        } catch {
            throw VisitReportError.saveFailed(error)
        }
    }
}

enum VisitReportError: Error {
    case missingRequiredFields
    case saveFailed(Error)
}
