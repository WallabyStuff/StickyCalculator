//
//  HistoryViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import UIKit
import ReactorKit
import RxCocoa
import RxDataSources

@objc
protocol HistoryViewDelegate {
    @objc optional func didTapHideButton()
    @objc optional func didDismissByTransition()
    @objc optional func didHistoryItemSelected(item: CalculationHistory)
}

class HistoryViewController: UIViewController, View {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var clearHistoryButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    typealias Reactor = HistoryViewReactor
    
    weak var delegate: HistoryViewDelegate?
    var disposeBag = DisposeBag()
    private var historyView = HistoryViewReactor()
    private var dataSource: RxTableViewSectionedAnimatedDataSource<CalculationHistorySection>?
    
    
    // MARK: - Initializers
    
    private func dataSourceFactory() -> RxTableViewSectionedAnimatedDataSource<CalculationHistorySection> {
        let dataSource = RxTableViewSectionedAnimatedDataSource<CalculationHistorySection> { [weak self] dataSource, tableView, indexPath, item in
            
            if item.isInvalidated { return UITableViewCell() }
            
            guard let self = self,
                  let cell = self.historyTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.historyTableCell.identifier)
                    as? HistoryTableViewCell else {
                return UITableViewCell()
            }
            
            let dateFormat = "yyyy-MM-dd hh:mm:dd"
            cell.dateTimeLabel.text = item.date.formattedDateString(format: dateFormat)
            
            cell.resultLabel.text = item.resultValue
            cell.numberSentenceLabel.text = item.numberSentence
            cell.numberSentenceLabel.makeAsAttributedNumberSentenceLabel()
            
            return cell
        }

        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            return true
        }
        
        return dataSource
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = dataSourceFactory()
        self.reactor = HistoryViewReactor()
        setupView()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if newCollection.isLandScapeOniPhone {
            dismiss(animated: false)
            delegate?.didDismissByTransition?()
        } else if newCollection.isPortraitOrLandscapeOniPad {
            dismiss(animated: true)
            delegate?.didDismissByTransition?()
        }
        
        reloadHistoryTableView()
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        setupHistoryTableView()
    }
    
    private func setupHistoryTableView() {
        let nibName = UINib(nibName: R.nib.historyTableViewCell.name, bundle: nil)
        historyTableView.register(nibName, forCellReuseIdentifier: R.reuseIdentifier.historyTableCell.identifier)
        historyTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        historyTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        historyTableView.separatorColor = R.color.lineGray()
        historyTableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Configuring
    
    func bind(reactor: Reactor) {
        // Action
        hideButton.rx.tap.asDriver()
            .drive(with: self, onNext: { vc, _ in
                vc.dismiss(animated: true)
                vc.delegate?.didTapHideButton?()
            }).disposed(by: disposeBag)
        
        historyTableView.rx.itemSelected
            .map { HistoryViewReactor.Action.itemSelected($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        clearHistoryButton.rx.tap.asDriver()
            .drive(with: self, onNext: { vc, _ in
                vc.showClearHistoryAlert()
            }).disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.calculationHistories }
            .distinctUntilChanged()
            .bind(to: historyTableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedItem }
            .distinctUntilChanged()
            .filter { $0 != nil }
            .bind(with: self, onNext: { vc, selectedHistoryItem in
                vc.delegate?.didHistoryItemSelected?(item: selectedHistoryItem!)
                vc.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    
    
    // MARK: - Methods
    
    private func showClearHistoryAlert() {
        let alert = UIAlertController(title: "Clear",
                                      message: "Are you sure you want to clear all histories?",
                                      preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { action in
            guard let reactor = self.reactor else { return }
            Observable.just(HistoryViewReactor.Action.clear)
                .bind(to: reactor.action)
                .dispose()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func reloadHistoryTableView() {
        guard let reactor = self.reactor else { return }
        
        Observable.just(HistoryViewReactor.Action.reload)
            .bind(to: reactor.action)
            .dispose()
    }
    
    func removeHistoryItem(_ indexPath: IndexPath) {
        guard let reactor = self.reactor else { return }
        
        Observable.just(HistoryViewReactor.Action.removeItem(indexPath))
            .bind(to: reactor.action)
            .dispose()
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
            title: "delete") { [weak self] action, view, completion in
                self?.removeHistoryItem(indexPath)
            }
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}
