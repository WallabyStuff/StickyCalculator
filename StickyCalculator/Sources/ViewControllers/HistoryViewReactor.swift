//
//  HistoryViewReactor.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import Foundation
import ReactorKit
import RxCocoa

class HistoryViewReactor: Reactor {
    enum Action {
        case reload
        case removeItem(IndexPath)
        case clear
        case itemSelected(IndexPath)
    }
    
    enum Mutation {
        case removeHistory(IndexPath)
        case fetchHistory
        case clearHistory
        case pasteHistory(IndexPath)
    }
    
    struct State {
        var calculationHistories: [CalculationHistorySection]
        var selectedItem: CalculationHistory?
    }
    
    
    // MARK: - Properties
    
    var initialState: State
    private var disposeBag = DisposeBag()
    private let calculationHistoryManager = CalculationHistoryManager()
    
    init() {
        self.initialState = State(
            calculationHistories: HistoryViewReactor.configureSections(),
            selectedItem: nil)
    }
    
    static func configureSections() -> [CalculationHistorySection] {
        var sections = [CalculationHistorySection]()
        
        let calculationHistoryManager = CalculationHistoryManager()
        calculationHistoryManager
            .fetchData()
            .subscribe(onSuccess: { historyItemsByDate in
                historyItemsByDate.forEach { items in
                    let section = CalculationHistorySection(header: items.date,
                                                            items: items.historyArray.reversed())
                    sections.append(section)
                }
            }).dispose()
        
        return sections
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .reload:
            return Observable.just(Mutation.fetchHistory)
            
        case .removeItem(let indexPath):
            return Observable.just(Mutation.removeHistory(indexPath))
            
        case .clear:
            return Observable.just(Mutation.clearHistory)
            
        case .itemSelected(let indexPath):
            return Observable.just(Mutation.pasteHistory(indexPath))
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .removeHistory(let indexPath):
            let item = state.calculationHistories[indexPath.section].items[indexPath.row]
            state.calculationHistories[indexPath.section].items.remove(at: indexPath.row)

            calculationHistoryManager.deleteData(item)
                .subscribe()
                .disposed(by: disposeBag)
            
        case .fetchHistory:
            state.calculationHistories = HistoryViewReactor.configureSections()
            
        case .clearHistory:
            calculationHistoryManager.deleteAll()
                .subscribe(onCompleted: {
                    for section in 0..<state.calculationHistories.count {
                        state.calculationHistories[section].items.removeAll()
                    }
                })
                .disposed(by: disposeBag)
            
        case .pasteHistory(let indexPath):
            state.selectedItem = state.calculationHistories[indexPath.section].items[indexPath.row]
        }
        
        return state
    }
}
