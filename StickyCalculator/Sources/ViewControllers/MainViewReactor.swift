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
        case updateWorkingState(WorkingState)
        case calculate
        case makeHapticFeedback(style: FeedbackManager.FeedbackStyle)
        case makeSoundFeedback(_ soundID: FeedbackManager.SystemSound)
        case updateCahce
        case saveHistory
    }
    
    struct State {
        var numberSentence: String
        var resultValue: String
        var workingState: WorkingState
        var onResult: Bool
    }
    
    
    // MARK: - Properties
    
    typealias WorkingState = (isWorking: Bool, `operator`: Operator?)
    let falseWorkingState = WorkingState(false, nil)
    
    var initialState: State
    private var disposeBag = DisposeBag()
    private let numberFormatter = NumberFormatter()
    private let feedbackManager = FeedbackManager()
    private let calculationCacheManager = CalculationCacheManager()
    private let calculationHistoryManager = CalculationHistoryManager()
    
    
    // MARK: - Initializer
    
    init() {
        let cache = calculationCacheManager.getCache()
        self.initialState = State(numberSentence: cache.numberSentence,
                                  resultValue: cache.resultValue,
                                  workingState: cache.workingState,
                                  onResult: cache.onResult)
        
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 99
        feedbackManager.prepareImpactFeedbackGenerator()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapNumberKeypad(let value):
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.updateResult(value.description)),
                Observable.just(Mutation.updateWorkingState(falseWorkingState)),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapOperator(let `operator`):
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.makeHapticFeedback(style: .selection)),
                Observable.just(Mutation.updateNumberSentence(`operator`)),
                Observable.just(Mutation.updateWorkingState(WorkingState(true, `operator`))),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapDecimal:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.makeResultDecimal),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapPercent:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.makeResultPercent),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapCancel:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.makeHapticFeedback(style: .light)),
                Observable.just(Mutation.resetResult("0")),
                Observable.just(Mutation.updateWorkingState(falseWorkingState)),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapBackspace:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemBackspaceKeySoundID)),
                Observable.just(Mutation.backspaceResult),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapPositivieNegative:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.updateResultPrefix),
                Observable.just(Mutation.updateCahce)
            ])
            
        case .didTapEqual:
            return Observable.concat([
                Observable.just(Mutation.makeSoundFeedback(.systemGeneralKeySoundID)),
                Observable.just(Mutation.makeHapticFeedback(style: .light)),
                Observable.just(Mutation.calculate),
                Observable.just(Mutation.updateCahce),
                Observable.just(Mutation.saveHistory)
            ])
            
        case .never:
            return Observable.never()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateResult(let newNumber):
            if state.resultValue.isZero || state.workingState.isWorking || state.onResult {
                state.resultValue.clear(with: newNumber)
                state.onResult = false
                state.workingState = WorkingState(false, nil)
            } else {
                state.resultValue.appendNumber(state.resultValue, newNumber, with: numberFormatter)
            }
            
        case .updateNumberSentence(let newOperator):
            if state.workingState.isWorking {
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
            if state.workingState.isWorking || state.onResult {
                state.resultValue.clear(with: "0")
                state.onResult = false
                state.workingState = falseWorkingState
            }
            
            if state.resultValue.isDecimal == false {
                state.resultValue.append(contentsOf: ".")
            }
            
        case .makeResultPercent:
            if state.resultValue.isUncompletedDecimal {
                state.resultValue = state.resultValue.removeDots()
            }
            
            state.resultValue = state.resultValue.multiply(0.01, with: numberFormatter)
            
        case .resetResult(let replacementResult):
            state.numberSentence.clear()
            state.resultValue = replacementResult
            
        case .backspaceResult:
            if state.resultValue.count == 1 {
                state.resultValue.clear(with: "0")
            } else {
                let backspacedResult = state.resultValue.description.dropLast().description
                state.resultValue = backspacedResult.toFormattedNumber(with: numberFormatter)
            }
            
        case .updateResultPrefix:
            if state.resultValue.isZero == false {
                if state.resultValue.isUncompletedDecimal {
                    state.resultValue = state.resultValue.removeDots()
                }
                
                if state.resultValue.isNegativeValue {
                    /// If it's negative
                    state.resultValue = state.resultValue.dropFirst().description
                } else {
                    /// If it's positive
                    state.resultValue = state.resultValue.multiply(-1, with: numberFormatter)
                }
                
                state.workingState = WorkingState(false, nil)
            }
            
        case .updateWorkingState(let newWorkingState):
            state.workingState = newWorkingState
            
        case .calculate:
            if state.onResult || state.numberSentence.isCompletedNumberSentence {
                let resultValue = state.resultValue
                state.numberSentence.clear()
                state.numberSentence = state.resultValue.pushOperator(.equal).self
                state.resultValue = resultValue
                
            } else {
                let newNumberSentence = state.numberSentence.pushNumber(state.resultValue, with: numberFormatter)
                state.numberSentence = "\(newNumberSentence) = "
                state.resultValue = newNumberSentence.calculate(with: numberFormatter)
            }
            
            state.workingState = falseWorkingState
            state.onResult = true
            
        case .makeHapticFeedback(let style):
            feedbackManager.makeHapticFeedback(style)
            
        case .makeSoundFeedback(let systemSoundID):
            feedbackManager.makeSoundFeedback(systemSoundID)
            
        case .updateCahce:
            calculationCacheManager.updateCache(numberSentence: state.numberSentence,
                                                resultValue: state.resultValue,
                                                workingState: state.workingState,
                                                onResult: state.onResult)
            
        case .saveHistory:
            let item = CalculationHistory(numberSentence: state.numberSentence,
                                          resultValue: state.resultValue)
            calculationHistoryManager.addData(item)
                .subscribe()
                .disposed(by: disposeBag)
            
        }
        
        return state
    }
}

