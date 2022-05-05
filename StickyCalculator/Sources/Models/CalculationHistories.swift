//
//  CalculationHistories.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/14.
//

import Foundation
import RealmSwift
import RxDataSources

class CalculationHistories: Object {
    
    
    // MARK: - Properties
    
    static let sectionHeaderDateFormat = "yyyy-MM-dd"
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
        self.date = CalculationHistories.getSectionHeaderString(Date())
        self.historyArray.append(newItem)
    }
    
    
    // MARK: - Methods
    
    override class func primaryKey() -> String? {
        return "date"
    }
    
    static func getSectionHeaderString(_ date: Date) -> String {
        let format = CalculationHistories.sectionHeaderDateFormat
        return date.formattedDateString(format: format)
    }
}

extension CalculationHistories: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        if isInvalidated {
            return UUID().uuidString
        } else {
            return date
        }
    }
}
