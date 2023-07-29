//
//  MediatorObservable.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation
class MediatorObservable: ObservableObject {
    let value: MediatorP
    
    init() {
        self.value = Mediator()
    }
    
    func handle<T>(command: T) -> Bool {
        return self.value.handle(command: command)
    }
}
