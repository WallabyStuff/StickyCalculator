//
//  CalculationHistory.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import Foundation
import RealmSwift
import RxDataSources

class CalculationHistory: Object {
    
    
    // MARK: - Porperties
    
    @objc dynamic var id: String = ""
    @objc dynamic var numberSentence: String = ""
    @objc dynamic var resultValue: String = ""
    @objc dynamic var date: Date = Date()
    
    
    // MARK: - Initializers
    
    convenience init(numberSentence: String, resultValue: String) {
        self.init()
        self.id = UUID().uuidString
        self.numberSentence = numberSentence
        self.resultValue = resultValue
        self.date = Date()
    }
    
    
    // MARK: - Methods
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["id", "numberSentence", "resultValue", "date"]
    }
    

}

extension CalculationHistory: IdentifiableType {
    typealias Identity = String

    var identity: String {
        if isInvalidated {
            /// return random id to prevent RLMException
            return UUID().uuidString
        } else {
            return id
        }
    }
}
