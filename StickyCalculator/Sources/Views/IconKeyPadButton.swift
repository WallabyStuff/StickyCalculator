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
    
    private static let imageSizeRatio: CGFloat = 0.25
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
    
    
    // MARK: - Configurations
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureInsets()
    }
    
    private func setupView() {
        titleLabel?.isHidden = true
    }
    
    private func configureInsets() {
        let resizedImageSize = (frame.width + frame.height) / 2 * Self.imageSizeRatio
        let horizontalInset = (frame.width - resizedImageSize) / 2
        let verticalInset = (frame.height - resizedImageSize) / 2
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
