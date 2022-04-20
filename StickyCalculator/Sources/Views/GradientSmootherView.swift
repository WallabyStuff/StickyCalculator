//
//  GradientSmootherView.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/17.
//

import UIKit

class GradientSmootherView: UIView {
    enum GradientDirection {
        case vertical
        case horizontal
    }
    
    
    // MARK: - Properties
    
    var gradientLayer = CAGradientLayer()
    var orientation: GradientDirection
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        self.orientation = .vertical
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, orientation: GradientDirection) {
        self.init(frame: frame)
        self.orientation = orientation
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        configureFrame()
    }
    
    
    // MARK: - Configurations
    
    private func configureView() {
        self.isUserInteractionEnabled = false
        
        switch orientation {
        case .horizontal:
            configureHorizontalGradientLayer()
        case .vertical:
            configureVerticalGradientLayer()
        }
    }
    
    private func configureHorizontalGradientLayer() {
        configureGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientLayer)
    }
    
    private func configureVerticalGradientLayer() {
        configureGradientLayer()
        self.layer.addSublayer(gradientLayer)
    }
    
    private func configureGradientLayer() {
        gradientLayer.removeFromSuperlayer()
        gradientLayer.colors = [R.color.backgroundColor()!.cgColor,
                                R.color.backgroundColor()!.withAlphaComponent(0).cgColor,
                                R.color.backgroundColor()!.withAlphaComponent(0).cgColor,
                                R.color.backgroundColor()!.cgColor]
        gradientLayer.locations = [0, 0.05, 0.95, 1.0]
        configureFrame()
    }
    
    private func configureFrame() {
        CALayer.performWithoutAnimation {
            gradientLayer.frame = bounds
        }
    }
}
