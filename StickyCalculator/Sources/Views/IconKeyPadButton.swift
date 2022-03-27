//
//  IconKeyButton.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import UIKit

@IBDesignable
class IconKeyPadButton: KeypadButton {
    
    // MARK: - Properties
    private var _imageSize: CGFloat = 0
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureInsets()
    }
    
    // MARK: - Setup
    private func setupView() {
        titleLabel?.isHidden = true
    }
    
    private func configureInsets() {
        let horizontalInset = (frame.width - _imageSize) / 2
        let verticalInset = (frame.height - _imageSize) / 2
        contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}

// MARK: - Designs
extension IconKeyPadButton {
    @IBInspectable
    var imageSize: CGFloat {
        get {
            return _imageSize
        }
        
        set {
            _imageSize = newValue
            configureInsets()
        }
    }
}
