//
//  String+DateFormatter.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/04.
//

import Foundation

extension Date {
    func formattedDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
