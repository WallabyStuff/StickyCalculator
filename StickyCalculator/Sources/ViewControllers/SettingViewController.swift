//
//  SettingViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/25.
//

import UIKit

import ReactorKit
import RxDataSources

class SettingViewController: BaseViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var settingItemTableView: UITableView!
    
    typealias Reactor = SettingViewReactor
    private var disposeBag = DisposeBag()
    private var reactor: SettingViewReactor
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    
    // MARK: - Initializers
    
    init(_ reactor: SettingViewReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    init?(_ coder: NSCoder, _ reactor: SettingViewReactor) {
        self.reactor = reactor
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        setupNavigationItem()
        setupDismissButton()
        setupSettingItems()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "setting".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDismissButton() {
        dismissButton.setTitle("dismiss".localized(), for: .normal)
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.borderColor = R.color.accentPink()?.cgColor
        dismissButton.layer.cornerRadius = dismissButton.frame.height / 2
    }
    
    private func setupSettingItems() {
        let toggleStyleNibName = UINib(nibName: "SwitchRowTableViewCell", bundle: nil)
        let linkStyleNibName = UINib(nibName: "TapActionRowTableViewCell", bundle: nil)
        settingItemTableView.register(toggleStyleNibName, forCellReuseIdentifier: R.reuseIdentifier.switchRowCell.identifier)
        settingItemTableView.register(linkStyleNibName, forCellReuseIdentifier: R.reuseIdentifier.tapActionRowCell.identifier)
        settingItemTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        settingItemTableView.separatorStyle = .none
    }
    
    
    // MARK: - Configuring
    
    func bind() {
        // Action
        dismissButton.rx.tap
            .asDriver()
            .drive(with: self, onNext: { vc, _ in
                vc.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        settingItemTableView.rx.itemSelected
            .asDriver()
            .drive(with: self, onNext: { [weak self] vc, indexPath in
                guard let self = self else { return }
                let item = self.reactor.currentState.settingItems[indexPath.row]
                if let linkedItem = item.appearance as? LinkedItem {
                    linkedItem.actionHandler(self)
                }
            }).disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.settingItems }
            .distinctUntilChanged()
            .bind(to: settingItemTableView.rx.items) { [weak self] tableView, index, item in
                guard let self = self else { return UITableViewCell() }
                
                if let toggleItem = item.appearance as? ToggleItem {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.switchRowCell.identifier)
                            as? SwitchRowTableViewCell else {
                        return UITableViewCell()
                    }
                    
                    cell.iconImageView.image = toggleItem.iconImage
                    cell.iconImageView.tintColor = toggleItem.iconColor
                    cell.titleLabel.text = toggleItem.title
                    cell.descriptionLabel.text = toggleItem.description
                    cell.itemSwitch.isOn = toggleItem.userDefaultsKey.currentValue as! Bool
                    toggleItem.actionHandler(cell.itemSwitch, self.disposeBag)
                    
                    return cell
                } else if let linkedItem = item.appearance as? LinkedItem {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tapActionRowCell.identifier)
                            as? TapActionRowTableViewCell else {
                        return UITableViewCell()
                    }
                    
                    cell.iconImageView.image = linkedItem.iconImage
                    cell.iconImageView.tintColor = linkedItem.iconColor
                    cell.titleLabel.text = linkedItem.title
                    cell.descriptionLabel.text = linkedItem.description
                    cell.linkHeaderLabel.text = linkedItem.linkHeader
                    
                    return cell
                } else {
                    return UITableViewCell()
                }
            }.disposed(by: disposeBag)
    }
}

extension SettingViewController: AppearanceSelectorViewDelegate {
    func didNewAppearanceSelected(_ selectedAppearance: Appearance) {
        settingItemTableView.reloadData()
    }
}
