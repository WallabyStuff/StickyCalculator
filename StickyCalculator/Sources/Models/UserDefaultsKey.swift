//
//  UserDefaultsKey.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/28.
//

import Foundation

enum UserDefaultsKey: String {
    case visualEffect = "general.visualEffect"
    case recordHistory = "general.recordHistory"
    case theme = "general.theme"
    
    var currentValue: Any {
        switch self {
        case .visualEffect:
            return UserDefaults.standard.value(forKey: UserDefaultsKey.visualEffect.rawValue) ?? true
        case .recordHistory:
            return UserDefaults.standard.value(forKey: UserDefaultsKey.recordHistory.rawValue) ?? true
        case .theme:
            return UserDefaults.standard.value(forKey: UserDefaultsKey.theme.rawValue) ?? Appearance.system.rawValue
        }
    }
}
