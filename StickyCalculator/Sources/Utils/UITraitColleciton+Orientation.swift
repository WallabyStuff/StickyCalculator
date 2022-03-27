//
//  UITraitColleciton+Orientation.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/26.
//

import UIKit

extension UITraitCollection {
    var isLandScapeOniPhone: Bool {
        if (horizontalSizeClass == .regular || horizontalSizeClass == .compact) &&
            verticalSizeClass == .compact {
            return true
        } else {
            return false
        }
    }
    
    var isPortraitOniPhone: Bool {
        if horizontalSizeClass == .compact &&
            (verticalSizeClass == .compact || verticalSizeClass == .regular) {
            return true
        } else {
            return false
        }
    }
    
    var isPortraitOrLandscapeOniPad: Bool {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return true
        } else {
            return false
        }
    }
}
