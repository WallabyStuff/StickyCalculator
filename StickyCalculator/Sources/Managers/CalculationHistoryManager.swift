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
                    if let object = self.fetchObject(by: CalculationHistoryByDate.formattedDate()) {
                        object.historyList.append(calculationHistory)
                    } else {
                        let newItem = CalculationHistoryByDate(calculationHistory)
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
    
    func fetchData() -> Single<[CalculationHistoryByDate]> {
        return Single.create { observer in
            do {
                let realmInstance = try Realm()
                let historiesByDate = Array(realmInstance.objects(CalculationHistoryByDate.self))
                observer(.success(historiesByDate.reversed()))
            } catch {
                observer(.failure(error))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteData(_ object: CalculationHistory) -> Completable {
        return Completable.create { observer in
            do {
                let realmInstance = try Realm()
                try realmInstance.write {
                    realmInstance.delete(object)
                }
                
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func deleteData(with identifier: String) -> Completable {
        return Completable.create { observer in
            do {
                let realmInstance = try Realm()
                let items = realmInstance.objects(CalculationHistory.self)
                
                try realmInstance.write {
                    if items.filter({ $0.id == identifier }).first != nil {
                        realmInstance.delete(items)
                    }
                }
                
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
    
    func fetchObject(by primaryKey: Any) -> CalculationHistoryByDate? {
        do {
            let realmInstance = try Realm()
            return realmInstance.object(ofType: CalculationHistoryByDate.self, forPrimaryKey: primaryKey)
        } catch {
            print(error)
        }
        
        return nil
    }
}
