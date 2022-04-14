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
        return Completable.create { observer in
            do {
                let realmInstance = try Realm()
                try realmInstance.write {
                    realmInstance.add(calculationHistory)
                }
                
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchData() -> Single<[CalculationHistory]> {
        return Single.create { observer in
            do {
                let realmInstance = try Realm()
                let calculationHistoryies = Array(realmInstance.objects(CalculationHistory.self))
                observer(.success(calculationHistoryies.reversed()))
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
}
