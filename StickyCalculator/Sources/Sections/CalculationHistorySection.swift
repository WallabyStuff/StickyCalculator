//
//  CalculationHistorySection.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/05.
//

import RxDataSources

struct CalculationHistorySection: Equatable, AnimatableSectionModelType {
    
    typealias Item = CalculationHistory
    typealias Identity = String
    
    // MARK: - Properties
    var items: [Item]
    var header: String
    var identity: String {
        return header
    }
    
    // MARK: - Initializers
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
    
    init(original: CalculationHistorySection, items: [CalculationHistory]) {
        self = original
        self.items = items
    }
}
