//
//  DeviceResolution.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/25.
//

import UIKit

enum DeviceResolution {
    case iPhone_13_ProMax
    
    var size: CGSize {
        switch self {
        case .iPhone_13_ProMax:
            return CGSize(width: 428, height: 926)
        }
    }
}
