//
//  CalculationHistory.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import Foundation
import RealmSwift
import RxDataSources

class CalculationHistory: Object, IdentifiableType {
    typealias Identity = String
    
    @objc dynamic var id: String = ""
    @objc dynamic var numberSentence: String = ""
    @objc dynamic var resultValue: String = ""
    @objc dynamic var date: Date = Date()
    
    convenience init(numberSentence: String, resultValue: String) {
        self.init()
        self.id = UUID().uuidString
        self.numberSentence = numberSentence
        self.resultValue = resultValue
        self.date = Date()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["id", "numberSentence", "resultValue", "date"]
    }
    
    var identity: String {
        if isInvalidated {
            /// return random id to prevent RLMException
            return UUID().uuidString
        } else {
            return id
        }
    }
}
