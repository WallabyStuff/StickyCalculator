//
//  ThemeSelectorViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/30.
//

import UIKit

import ReactorKit
import RxCocoa

protocol AppearanceSelectorViewDelegate: AnyObject {
    func didNewAppearanceSelected(_ selectedAppearance: Appearance)
}

class AppearanceSelectorViewController: BaseViewController, View {
    
    
    // MARK: - Properties
    @IBOutlet weak var itemTableView: UITableView!
    
    typealias Reactor = AppearnaceSelectorViewReactor
    weak var delegate: AppearanceSelectorViewDelegate?
    var disposeBag = DisposeBag()
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = AppearnaceSelectorViewReactor()
        setupView()
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        setupNavigationBar()
        setupItemTableView()
    }
    
    private func setupNavigationBar() {
        title = "appearance".localized()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupItemTableView() {
        let nibName = UINib(nibName: "OptionRowTableViewCell", bundle: nil)
        itemTableView.register(nibName, forCellReuseIdentifier: R.reuseIdentifier.optionRowCell.identifier)
        itemTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        itemTableView.separatorStyle = .none
    }
    
    func bind(reactor: AppearnaceSelectorViewReactor) {
        // Action
        itemTableView.rx.itemSelected
            .asDriver()
            .drive(with: self, onNext: { vc, indexPath in
                guard let cell = vc.itemTableView.cellForRow(at: indexPath)
                        as? OptionRowTableViewCell else {
                    return
                }
                
                let selectedAppearance = reactor.currentState.appearanceItems[indexPath.row]
                
                cell.checkImageView.isHidden = false
                UserDefaults.standard.set(selectedAppearance.rawValue,
                                          forKey: UserDefaultsKey.theme.rawValue)
                vc.delegate?.didNewAppearanceSelected(selectedAppearance)
                vc.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.appearanceItems }
            .distinctUntilChanged()
            .bind(to: itemTableView.rx.items) { tableView, index, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.optionRowCell.identifier) as?
                        OptionRowTableViewCell else {
                    return UITableViewCell()
                }
                
                if index == UserDefaultsKey.theme.currentValue as! Int {
                    cell.checkImageView.isHidden = false
                }
                
                cell.titleLabel.text = Appearance.allCases[index].title
                return cell
            }.disposed(by: disposeBag)
    }
}
