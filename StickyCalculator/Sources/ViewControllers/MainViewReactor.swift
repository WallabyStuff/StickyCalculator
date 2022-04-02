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
        case didTapNumberKeypad(Int)
        case didTapOperator(Operator)
        case didTapDecimal
        case didTapPercent
        case didTapCancel
        case didTapBackspace
        case didTapPositivieNegative
        case didTapEqual
        case never
    }
    
    enum Mutation {
        case updateResult(String)
        case updateNumberSentence(Operator)
        case makeResultDecimal
        case makeResultPercent
        case backspaceResult
        case resetResult(String)
        case updateResultPrefix
        case updateWorkingState(Bool)
        case calculate
    }
    
    struct State {
        var numberSentence: String
        var resultValue: String
        var isWorking: Bool
        var onResult: Bool
    }
    
    var initialState: State
    let numberFormatter = NumberFormatter()
    
    init() {
        self.initialState = State(numberSentence: "", resultValue: "0", isWorking: false, onResult: false)
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 99
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapNumberKeypad(let value):
            return Observable.concat([
                Observable.just(Mutation.updateResult(value.description)),
                Observable.just(Mutation.updateWorkingState(false))
            ])
            
        case .didTapOperator(let `operator`):
            return Observable.concat([
                Observable.just(Mutation.updateNumberSentence(`operator`)),
                Observable.just(Mutation.updateWorkingState(true))
            ])
            
        case .didTapDecimal:
            return Observable.just(Mutation.makeResultDecimal)
            
        case .didTapPercent:
            return Observable.just(Mutation.makeResultPercent)
            
        case .didTapCancel:
            return Observable.concat([
                Observable.just(Mutation.resetResult("0")),
                Observable.just(Mutation.updateWorkingState(false))
            ])
            
        case .didTapBackspace:
            return Observable.just(Mutation.backspaceResult)
            
        case .didTapPositivieNegative:
            return Observable.just(Mutation.updateResultPrefix)
            
        case .didTapEqual:
            return Observable.just(Mutation.calculate)
            
        case .never:
            return Observable.never()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateResult(let newNumber):
            if state.resultValue.isZero || state.isWorking || state.onResult {
                state.resultValue = newNumber
                state.onResult = false
                state.isWorking = false
            } else {
                state.resultValue.appendNumber(state.resultValue, newNumber, with: numberFormatter)
            }
            
        case .updateNumberSentence(let newOperator):
            if state.isWorking {
                if state.numberSentence.hasOperatorSuffix {
                    state.numberSentence = state.numberSentence.replaceOperatorSuffix(with: newOperator)
                }
            } else {
                if state.onResult == true || state.numberSentence.isCompletedNumberSentence {
                    state.numberSentence.clear()
                    state.onResult = false
                }
                
                let newNumberSentence = state.numberSentence.pushNumber(state.resultValue, with: numberFormatter)
                state.numberSentence.pushOperator(newOperator)
                state.resultValue = newNumberSentence.calculate(with: numberFormatter)
            }
            
        case .makeResultDecimal:
            if state.isWorking {
                state.resultValue.clear(with: "0")
                state.isWorking = false
            }
            
            if state.resultValue.isDecimal == false {
                state.resultValue.append(contentsOf: ".")
            }
            
        case .makeResultPercent:
            state.resultValue = state.resultValue.multiply(0.001, with: numberFormatter)
            
        case .resetResult(let replacementResult):
            state.numberSentence.clear()
            state.resultValue = replacementResult
            
        case .backspaceResult:
            if state.resultValue.count == 1 {
                state.resultValue.clear(with: "0")
            } else {
                let backspacedResult = state.resultValue.description.dropLast().description
                state.resultValue = backspacedResult.description
            }
            
        case .updateResultPrefix:
            if state.resultValue.isZero == false {
                if state.resultValue.hasPrefix("-") {
                    /// If it's negative
                    state.resultValue = state.resultValue.dropFirst().description
                } else {
                    /// If it's positive
                    state.resultValue = state.resultValue.multiply(-1, with: numberFormatter)
                }
                
                state.isWorking = false
            }
            
        case .updateWorkingState(let newValue):
            state.isWorking = newValue
            
        case .calculate:
            if state.onResult || state.numberSentence.isCompletedNumberSentence {
                state.resultValue.pushOperator(.equal)
            } else {
                let newNumberSentence = state.numberSentence.pushNumber(state.resultValue, with: numberFormatter)
                state.numberSentence = "\(newNumberSentence) = "
                state.resultValue = newNumberSentence.calculate(with: numberFormatter)
            }
            
            state.isWorking = false
            state.onResult = true
        }
        
        return state
    }
}

