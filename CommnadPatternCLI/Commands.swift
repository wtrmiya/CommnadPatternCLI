//
//  Commands.swift
//  CommnadPatternCLI
//
//  Created by Wataru Miyakoshi on 2022/04/06.
//

import Foundation

protocol Command {
    func execute()
}

class GenericCommand<T> : Command {
    private var receiver: T
    private var instructions:((T) -> Void)
    
    init(receiver: T, instructions: @escaping (T) -> Void) {
        self.receiver = receiver
        self.instructions = instructions
    }
    
    func execute() {
        instructions(receiver)
    }
    
    static func createCommand(receiver: T, instructions: @escaping ((T) -> Void)) -> Command {
        return GenericCommand(receiver: receiver, instructions: instructions)
    }
}
