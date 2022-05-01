//
//  SettingViewReactor.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/25.
//

import Foundation
import ReactorKit

class SettingViewReactor: Reactor {
    
    
    // MARK: - Properties
    
    typealias Action = NoAction
    var initialState: State
    
    struct State {
        let settingItems = SettingItem.allCases
    }
    
    
    // MARK: - Initializer
    
    init() {
        self.initialState = State()
    }
}
