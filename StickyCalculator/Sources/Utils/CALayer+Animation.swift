//
//  CALayer+WithoutAnimation.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/17.
//

import UIKit

extension CALayer {
    class func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void){
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
}
