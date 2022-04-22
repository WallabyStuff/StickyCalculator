//
//  UIView+Flash.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/22.
//

import UIKit

extension UIView {
    func flash(with flashColor: UIColor) {
        let oldColor = self.backgroundColor
        self.backgroundColor = flashColor
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseInOut]) {
            self.backgroundColor = oldColor
        }
    }
}
