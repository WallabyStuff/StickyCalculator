//
//  ToastStyle.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/20.
//

import UIKit

public class ToastStyle {
    
    
    // MARK: - Properties
    
    public var backgroundColor: UIColor = .black
    public var messageColor: UIColor = .white

    public var cornerRadius: CGFloat = 12
    public var borderWidth: CGFloat = 0
    public var borderColor: UIColor = .systemBackground

    public var font: UIFont = UIFont.systemFont(ofSize: 15)

    public var isShadowHidden: Bool = false
    public var shadowRadius: CGFloat = 20
    public var shadowColor: UIColor = .black
    public var shadowOffset: CGSize = CGSize(width: 0, height: 4)
    public var shadowOpacity: Float = 0.1
    
    
    // MARK: - Initializer
    
    public init() {}
}

public class ToastManager {
    public static let shared = ToastManager()
    
    public var style = ToastStyle()
}
