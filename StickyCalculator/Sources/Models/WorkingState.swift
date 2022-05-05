//
//  WorkingState.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/17.
//

import Foundation

struct WorkingState: Equatable {
    var isWorking: Bool
    var `operator`: Operator?
    
    init(_ isWorking: Bool, _ `operator`: Operator?) {
        self.isWorking = isWorking
        self.`operator` = `operator`
    }
}
