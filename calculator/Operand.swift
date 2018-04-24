//
//  Operator.swift
//  calculator
//
//  Created by White on 2018/4/21.
//  Copyright © 2018年 White. All rights reserved.
//

import Foundation

struct CalculatorOperand {
    private var accumulator: String?
    
    
    private enum Operation {
        case changeAssign //2
        case percentTage //3
        case binaryOperation((Double,Double)->Double) //4~7
        case equals //8
    }
    
    private var operations: Dictionary<Int,Operation> = [
        2: Operation.changeAssign,
        3: Operation.percentTage,
        4: Operation.binaryOperation({ $0 / $1 }),
        5: Operation.binaryOperation({ $0 * $1 }),
        6: Operation.binaryOperation({ $0 - $1 }),
        7: Operation.binaryOperation({ $0 + $1 }),
        8: Operation.equals
    ]
    
    mutating func performedOperation(_ number: Int) {
        print("\(number)")
        if let operation = operations[number] {
            switch operation {
            case .changeAssign:
                if accumulator != nil {
                    accumulator = String(Double(accumulator!)! * -1)
                }
            case .percentTage:
                if accumulator != nil {
                    accumulator = String(Double(accumulator!)! * 0.01)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: Double(accumulator!)!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator! = String(pendingBinaryOperation!.perform(with: Double(accumulator!)!))
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with SecondOperand: Double) -> Double {
            if SecondOperand == 0  {
                return 0
            }else {
                return function(firstOperand, SecondOperand)
            }
            
        }
    }
    
    mutating func passValue(_ getValue: String){
        accumulator = getValue
    }
    
    var result: String? {
        get {
            print(accumulator ?? "?")
            return accumulator
        }
    }
}
