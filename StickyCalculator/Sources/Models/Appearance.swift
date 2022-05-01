//
//  Appearance.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

enum Appearance: Int, CaseIterable {
    case system = 0
    case light = 1
    case dark = 2
    
    var title: String {
        switch self {
        case .system:
            return "appearance.system".localized()
        case .light:
            return "appearance.light".localized()
        case .dark:
            return "appearance.dark".localized()
        }
    }
    
    static var current: Appearance {
        return Appearance.allCases[UserDefaultsKey.theme.currentValue as! Int]
    }
}
