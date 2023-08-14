//
//  Timestamp.swift
//  Urban
//
//  Created by Juliana Estrela on 14/08/2023.
//

import Foundation
import FirebaseFirestore

extension Timestamp {
    func toString() -> String {
        let date = self.dateValue()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
