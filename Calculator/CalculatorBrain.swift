//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Xiang, Zhuyuan | Matt | ISDOD on 25/10/16.
//  Copyright © 2016 Xiang, Zhuyuan | Matt | ISDOD. All rights reserved.
//

import Foundation


class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand:Double){
        accumulator = operand
    }
    
    var operations:Dictionary<String,Operation> = [
        "π": Operation.Constant(M_PI), // M_PI,
        "e":Operation.Constant(M_E), //M_E,
        "±":Operation.UnaryOperation({-$0}),
        "√":Operation.UnaryOperation(sqrt), // sqrt,
        "cos":Operation.UnaryOperation(cos), // cos
        "×":Operation.BinaryOperation({$0 * $1 }), //({(op1,op2) in return op1*op2})
        "÷":Operation.BinaryOperation({$0 / $1 }),
        "+":Operation.BinaryOperation({$0 + $1 }),
        "−":Operation.BinaryOperation({$0 - $1 }),
        "=":Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
        
        
    }
    
    private func executePendingBinaryOperation ()
    {
        if pending != nil{
            accumulator = pending!.binaryFunciton(pending!.firstOperand, accumulator)
            pending = nil
        }
        
    }
    
    private var pending: PendingBinaryOperationInfo?
    private struct PendingBinaryOperationInfo{
        var binaryFunciton: (Double,Double)->Double
        var firstOperand:Double
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
    
    func performOperation(symbol:String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .BinaryOperation(let foo):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunciton: foo, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            case .UnaryOperation(let foo):
                accumulator = foo(accumulator)
                
            }
        }
    }
}
