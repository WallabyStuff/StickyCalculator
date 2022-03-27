//
//  HistoryViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import UIKit
import ReactorKit
import RxCocoa

@objc
protocol HistoryViewDelegate {
    @objc optional func didTapHideButton()
    @objc optional func didDismissByTransition()
}

class HistoryViewController: UIViewController, View {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var clearHistoryButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    weak var delegate: HistoryViewDelegate?
    var disposeBag = DisposeBag()
    private var historyView = HistoryViewReactor()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        setupHistoryTableView()
    }
    
    private func setupHistoryTableView() {
        let nibName = UINib(nibName: R.nib.historyTableViewCell.name, bundle: nil)
        historyTableView.register(nibName, forCellReuseIdentifier: R.reuseIdentifier.historyTableCell.identifier)
        
        historyTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        historyTableView.separatorColor = R.color.lineGray()
        historyTableView.tableFooterView = UIView()
    }
    
    
    // MARK: - Configuring
    
    func bind(reactor: HistoryViewReactor) {
        // Action
        hideButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true)
                self?.delegate?.didTapHideButton?()
            }).disposed(by: disposeBag)
        
        // State
    }
}
