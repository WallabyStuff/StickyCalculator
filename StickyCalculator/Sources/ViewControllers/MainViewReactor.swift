//
//  MainReacorKit.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import Foundation
import ReactorKit
import RxCocoa

class MainViewReactor: Reactor {
    enum Action {
        case never
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
        switch action {
        case .never:
            return Observable.never()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
