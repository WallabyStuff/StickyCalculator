//
//  HistoryViewReactor.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import Foundation
import ReactorKit
import RxCocoa

class HistoryViewReactor: Reactor {
    enum Action {
        case clear
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return Observable.never()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
//        var state = state
        
//        return state
    }
}
