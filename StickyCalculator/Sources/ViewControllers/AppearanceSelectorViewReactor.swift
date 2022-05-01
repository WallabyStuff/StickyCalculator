//
//  AppearanceSelectorViewReactor.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

import ReactorKit

class AppearnaceSelectorViewReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let appearanceItems = Appearance.allCases
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}
