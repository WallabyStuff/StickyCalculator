//
//  String+NSExpression.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/30.
//

import Foundation

/// Actual calcuatation logics
extension String {
    func multiply(_ value: Double, with: NumberFormatter) -> String {
        let newNumberSentence = "\(self) * \(value)"
        return newNumberSentence.calculate(with: with)
    }
    
    func calculate(with numberFormatter: NumberFormatter) -> String {
        let nan = "NaN"
        let numberSentence = self.prepareForCalculate()
        
        if numberSentence.contains(nan) {
            return nan
        }
        
        let formattedExpression = NSExpression(format: numberSentence)
        
        if let result = formattedExpression.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double {
            return numberFormatter.string(from: NSNumber(value: result)) ?? nan
        } else {
            return nan
        }
    }
    
    func prepareForCalculate() -> String {
        /// remove commas for calculatable
        var numberSentence = self.removeCommas()
        
        /// replace noncomputable operators to computable operators (e.g "x" -> "*")
        Operator.allCases.forEach { `operator` in
            numberSentence = numberSentence.replacingOccurrences(of: `operator`.rawValue, with: `operator`.formattableString)
        }
        
        return numberSentence
    }
}


/// NumberSentence modification logics
extension String {
    mutating func pushOperator(_ newOperator: Operator) {
        self = "\(self)\(newOperator.withWhiteSpace)"
    }
    
    @discardableResult
    mutating func pushNumber(_ newNumber: String, with: NumberFormatter) -> String {
        self = "\(self)\(newNumber.toFormattedNumber(with: with))"
        return self
    }
    
    mutating func appendNumber(_ oldNumber: String, _ newNumber: String, with: NumberFormatter) {
        self = "\(oldNumber)\(newNumber)".toFormattedNumber(with: with)
    }
    
    mutating func appendWhiteSpace() {
        self = "\(self)\(whiteSpace)"
    }
    
    func toFormattedNumber(with numberFormatter: NumberFormatter) -> String {
        if let number = Double(self.removeCommas()) {
            return numberFormatter.string(from: NSNumber(value: number)) ?? "0"
        } else {
            return "0"
        }
    }
    
    func replaceOperatorSuffix(with newOperator: Operator) -> String {
        var numberSentence = self
        numberSentence.removeLast()
        numberSentence.removeLast()
        numberSentence.append("\(newOperator.rawValue) ")
        
        return numberSentence
    }
    
    var hasOperatorSuffix: Bool {
        return self.hasSuffix(Operator.addition.withWhiteSpace) ||
            self.hasSuffix(Operator.subtraction.withWhiteSpace) ||
            self.hasSuffix(Operator.multiplication.withWhiteSpace) ||
            self.hasSuffix(Operator.division.withWhiteSpace)
    }
    
    mutating func clear() {
        self = ""
    }
    
    mutating func clear(with initialString: String) {
        clear()
        self = initialString
    }
    
    var isZero: Bool {
        if self == "0" || self == "0." {
            return true
        } else {
            return false
        }
    }
    
    var isCompletedNumberSentence: Bool {
        if self.contains("=") {
            return true
        } else {
            return false
        }
    }
    
    var isDecimal: Bool {
        if self.contains(".") {
            return true
        } else {
            return false
        }
    }
    
    func removeCommas() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    
    var whiteSpace: String {
        return " "
    }
}


/// To make NSExpression to calculate float numbers
extension NSExpression {

    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
           return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        @unknown default:
            fatalError()
        }
        return self
    }
}
