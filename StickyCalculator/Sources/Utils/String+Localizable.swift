//
//  String+Localizable.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/14.
//

import Foundation

extension String {
    func localized(_ comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
