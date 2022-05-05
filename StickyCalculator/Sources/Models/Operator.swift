//
//  Operator.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/30.
//

import Foundation

enum Operator: String, CaseIterable, Equatable {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "x"
    case division = "÷"
    case equal = "="
    case other = ""
    
    var withWhiteSpace: String {
        if self == .other {
            return ""
        } else {
            return " \(self.rawValue) "
        }
    }
    
    var formattableString: String {
        switch self {
        case .addition:
            return "+"
        case .subtraction:
            return "-"
        case .multiplication:
            return "*"
        case .division:
            return "/"
        case .equal:
            return "="
        case .other:
            return ""
        }
    }
}
