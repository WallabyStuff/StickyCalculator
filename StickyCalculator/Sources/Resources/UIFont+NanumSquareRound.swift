//
//  UIFont+NanumSquareRound.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/22.
//

import UIKit

extension UIFont {
    class func nanumSquareRound(type: NanumSquareRoundType, size: CGFloat) -> UIFont? {
        guard let font = UIFont(name: type.name, size: size) else {
            print("fail to load font")
            return nil
        }
        
        return font
    }
    
    public enum NanumSquareRoundType {
        case light
        case regular
        case bold
        case extraBold
        
        var name: String {
            switch self {
            case .light:
                return "NanumSquareRoundOTFL"
            case .regular:
                return "NanumSquareRoundOTFR"
            case .bold:
                return "NanumSquareRoundOTFB"
            case .extraBold:
                return "NanumSquareRoundOTFEB"
            }
        }
    }
}
