//
//  UIView+Animation.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/17.
//

import UIKit

extension UIView {
    func fadeIn(duration: CGFloat = 0.2) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }
    
    func fadeOut(duration: CGFloat = 0.2) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }
}
