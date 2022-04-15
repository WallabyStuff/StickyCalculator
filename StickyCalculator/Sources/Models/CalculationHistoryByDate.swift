//
//  CalculationHistories.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/14.
//

import Foundation
import RealmSwift
import RxDataSources

class CalculationHistoryByDate: Object {
    
    
    // MARK: - Properties
    
    @objc dynamic var date: String = ""
    let historyList = List<CalculationHistory>()
    var historyArray: [CalculationHistory] {
        get {
            return historyList.map { $0 }
        }
        set {
            self.historyList.removeAll()
            self.historyList.append(objectsIn: newValue)
        }
    }
    
    
    // MARK: - Initializers
    
    convenience init(_ newItem: CalculationHistory) {
        self.init()
        self.date = CalculationHistoryByDate.formattedDate()
        self.historyArray.append(newItem)
    }
    
    
    // MARK: - Methods
    
    override class func primaryKey() -> String? {
        return "date"
    }
    
    static func formattedDate() -> String {
        return Date().formattedDateString(format: "yyyy-MM-dd")
    }
}

extension CalculationHistoryByDate: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        if isInvalidated {
            return UUID().uuidString
        } else {
            return date
        }
    }
}
