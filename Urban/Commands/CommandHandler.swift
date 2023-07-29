//
//  CommandHandler.swift
//  Urban
//
//  Created by Juliana Estrela on 29/07/2023.
//

import Foundation

protocol CommandHandler<CommandType> {
    associatedtype CommandType
    func handle(command: CommandType) -> Bool
}
