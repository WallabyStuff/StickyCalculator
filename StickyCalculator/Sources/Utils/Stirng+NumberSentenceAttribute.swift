//
//  UILabel+ExpressionAttribute.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/28.
//

import UIKit

extension UITextView {
    
}

extension UILabel {
    func makeAsAttributedNumberSentenceLabel() {
        self.attributedText = NSMutableAttributedString(string: text ?? "").attributedNumberSentenceString()
    }
}

extension UITextView {
    func makeAsAttributedNumberSentenceText() {
        self.attributedText = NSMutableAttributedString(string: text).attributedNumberSentenceString()
        self.font = UIFont.nanumSquareRound(type: .bold, size: 20)
        self.textAlignment = .right
    }
}

extension NSMutableAttributedString {
    func attributedNumberSentenceString() -> NSMutableAttributedString {
        let text = self.string
        
        let defaultTextColor = R.color.textGray() ?? .label
        let fourRulesOperatorColor = R.color.accentYellow() ?? .label
        let equalOperatorColor = R.color.accentColor() ?? .label
        let attributedString = NSMutableAttributedString(string: text)
        
        /// Set default text color first
        attributedString.addAttribute(.foregroundColor, value: defaultTextColor, range: text.fullRange)
        
        do {
            /// Highlight the four rule symbols
            let pattern = "( \\+ | \\- | x | ÷ )"
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            
            let matches = regex.matches(in: text, range: text.fullRange)
            matches.forEach {
                attributedString.addAttribute(.foregroundColor, value: fourRulesOperatorColor, range: $0.range)
            }
            
            /// Highlight the equal symbol
            let equalSymbolRange = NSString(string: text).range(of: "=")
            attributedString.addAttribute(.foregroundColor, value: equalOperatorColor, range: equalSymbolRange)
            
            return attributedString
        } catch {
            print(error.localizedDescription)
            return NSMutableAttributedString()
        }
    }
}

extension String {
    var fullRange: NSRange {
        return NSMakeRange(0, self.count)
    }
}
