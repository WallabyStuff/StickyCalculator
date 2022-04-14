//
//  CacheManager.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import Foundation

class CalculationCacheManager {
    
    static let NUMBER_SENTENCE_KEY = "NUMBER_SENTENCE"
    static let RESULT_VALUE_KEY = "RESULT_VALUE"
    static let IS_WORKING_STATE_KEY = "IS_WORKING"
    static let WORKING_STATE_OPERATOR_KEY = "IS_WORKING_OPERATOR"
    static let ON_RESULT_STATE_KEY = "ON_RESULT"
    typealias Cache = (numberSentence: String, resultValue: String, workingState: MainViewReactor.WorkingState, onResult: Bool)
    
    func updateCache(numberSentence: String, resultValue: String, workingState: MainViewReactor.WorkingState, onResult: Bool) {
        UserDefaults.standard.set(numberSentence, forKey: CalculationCacheManager.NUMBER_SENTENCE_KEY)
        UserDefaults.standard.set(resultValue, forKey: CalculationCacheManager.RESULT_VALUE_KEY)
        UserDefaults.standard.set(workingState.isWorking, forKey: CalculationCacheManager.IS_WORKING_STATE_KEY)
        UserDefaults.standard.set(workingState.`operator`?.rawValue ?? "", forKey: CalculationCacheManager.WORKING_STATE_OPERATOR_KEY)
        UserDefaults.standard.set(onResult, forKey: CalculationCacheManager.ON_RESULT_STATE_KEY)
    }
    
    func getCache() -> Cache {
        let numberSentence = UserDefaults.standard.string(forKey: CalculationCacheManager.NUMBER_SENTENCE_KEY) ?? ""
        let resultValue = UserDefaults.standard.string(forKey: CalculationCacheManager.RESULT_VALUE_KEY) ?? "0"
        let isWorking = UserDefaults.standard.bool(forKey: CalculationCacheManager.IS_WORKING_STATE_KEY)
        let `operator`: Operator? = Operator(rawValue: UserDefaults.standard.string(forKey: CalculationCacheManager.WORKING_STATE_OPERATOR_KEY) ?? "")
        let onResult = UserDefaults.standard.bool(forKey: CalculationCacheManager.ON_RESULT_STATE_KEY)
        
        return Cache(numberSentence, resultValue, MainViewReactor.WorkingState(isWorking, `operator`), onResult)
    }
}
