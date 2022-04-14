//
//  UILabel+ExpressionAttribute.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/28.
//

import UIKit

extension UILabel {
    func makeAsAttributedNumberSentenceLabel() {
        guard let text = text else {
            return
        }
        
        let fourRulesOperatorColor = R.color.accentYellow() ?? .label
        let equalOperatorColor = R.color.accentColor() ?? .label
        
        do {
            /// Highlight the four rule symbols
            let pattern = "( \\+ | \\- | x | ÷ )"
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let attributedString = NSMutableAttributedString(string: text)
            
            let matches = regex.matches(in: text, range: text.fullRange)
            matches.forEach {
                attributedString.addAttribute(.foregroundColor, value: fourRulesOperatorColor, range: $0.range)
            }
            
            /// Highlight the equal symbol
            let equalSymbolRange = NSString(string: text).range(of: "=")
            attributedString.addAttribute(.foregroundColor, value: equalOperatorColor, range: equalSymbolRange)
            
            self.attributedText = attributedString
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension String {
    var fullRange: NSRange {
        return NSMakeRange(0, self.count)
    }
}
