//
//  TextKeypadButton.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/24.
//

import UIKit

@IBDesignable
class TextKeypadButton: KeypadButton {
    
    
    // MARK: - Properties

    private static let fontSizeRatio: CGFloat = 0.4
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Configurations
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFont()
    }
    
    private func configureFont() {
        titleLabel?.font = UIFont.nanumSquareRound(type: .bold,
                                                   size: (frame.height + frame.width) / 2 * Self.fontSizeRatio)
    }
}
