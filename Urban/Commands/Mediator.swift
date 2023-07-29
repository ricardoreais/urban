//
//  Mediator.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation

class Mediator : MediatorP {
    private var handlers: [String: Any] = [:]
    
    init() {
        self.registerHandler(handler: CreateUserCommandHandler())
    }
    
    func registerHandler<T>(handler: any CommandHandler<T>) {
        let key = String(describing: T.self)
        handlers[key] = handler
    }
    	
    func handle<T>(command: T) -> Bool {
        let key = String(describing: type(of: command))
        if let handler = handlers[key] as? any CommandHandler<T> {
            return handler.handle(command: command)
        }
        
        return false
    }
}

protocol MediatorP {
    func handle<T>(command: T) -> Bool
}
