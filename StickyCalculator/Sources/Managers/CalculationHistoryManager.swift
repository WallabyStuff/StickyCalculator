//
//  CalculationHistoryManager.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class CalculationHistoryManager {
    func addData(_ calculationHistory: CalculationHistory) -> Completable {
        return Completable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                let realmInstance = try Realm()
                try realmInstance.write {
                    if let object = self.fetchObject(by: CalculationHistories.getSectionHeaderString(Date())) {
                        object.historyList.append(calculationHistory)
                    } else {
                        let newItem = CalculationHistories(calculationHistory)
                        realmInstance.add(newItem)
                    }
                }
                
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchData() -> Single<[CalculationHistories]> {
        return Single.create { observer in
            do {
                let realmInstance = try Realm()
                let historiesByDate = Array(realmInstance.objects(CalculationHistories.self))
                observer(.success(historiesByDate.reversed()))
            } catch {
                observer(.failure(error))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteData(_ object: CalculationHistory) -> Completable {
        return Completable.create { [weak self] observer in
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                let realmInstance = try Realm()
                let date = object.date
                
                try realmInstance.write {
                    realmInstance.delete(object)
                }
                
                self.deleteParentDataIfNeeded(date)
                
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteAll() -> Completable {
        return Completable.create { observer in
            do {
                let realmInstance = try Realm()
                try realmInstance.write({
                    realmInstance.deleteAll()
                })
                
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}

extension CalculationHistoryManager {
    func deleteParentDataIfNeeded(_ date: Date) {
        if let object = fetchObject(by: CalculationHistories.getSectionHeaderString(date)) {
            if !object.historyList.isEmpty {
                return
            }
            
            do {
                let realmInstance = try Realm()
                try realmInstance.write {
                    realmInstance.delete(object)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func fetchObject(by primaryKey: Any) -> CalculationHistories? {
        do {
            let realmInstance = try Realm()
            return realmInstance.object(ofType: CalculationHistories.self, forPrimaryKey: primaryKey)
        } catch {
            print(error)
        }
        
        return nil
    }
}
