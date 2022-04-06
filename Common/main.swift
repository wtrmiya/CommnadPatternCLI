//
//  main.swift
//  CommnadPatternCLI
//
//  Created by Wataru Miyakoshi on 2022/04/06.
//

import Foundation

let calc = Calculator()
calc.add(10)
calc.multiply(4)
calc.subtract(3)

print("Total: \(calc.total)")

calc.undo()

print("Total: \(calc.total)")
