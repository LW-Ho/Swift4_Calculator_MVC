//
//  Operator.swift
//  calculator
//
//  Created by White on 2018/4/21.
//  Copyright © 2018年 White. All rights reserved.
//

import Foundation

struct CalculatorOperand {
    private var accumulator: Double?
    
    private enum Operation {
        case clear  //1
        case changeAssign //2
        case percentTage //3
        case binaryOperation((Double,Double)->Double) //4~7
        case equals //8
        case dot //9
    }
    
    private var operations: Dictionary<Int,Operation> = [
        1: Operation.clear,
        2: Operation.changeAssign,
        3: Operation.percentTage,
        4: Operation.binaryOperation({ $0 / $1 }),
        5: Operation.binaryOperation({ $0 * $1 }),
        6: Operation.binaryOperation({ $0 - $1 }),
        7: Operation.binaryOperation({ $0 + $1 }),
        8: Operation.equals,
        9: Operation.dot
    ]
    
    mutating func performedOperation(_ number: Int) {
        print("\(number)")
        if let operation = operations[number] {
            switch operation {
            case .clear:
                accumulator = 0
            case .changeAssign:
                if accumulator != nil {
                    print("In changeAssign ...")
                    accumulator = accumulator! * -1
                }
            case .percentTage:
                if accumulator != nil {
                    print("In PercentTage ...")
                    accumulator = accumulator! * 0.01
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .dot:
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with SecondOperand: Double) -> Double {
            return function(firstOperand, SecondOperand)
        }
    }
    
    mutating func passValue(_ getValue: Double){
        accumulator = getValue
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
