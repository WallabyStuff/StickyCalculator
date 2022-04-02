//
//  ViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/16.
//

import UIKit
import ReactorKit
import RxCocoa

class MainViewController: UIViewController, View {

    
    // MARK: - Properties
    
    static let PREFERRED_KEYPAD_WIDTH: CGFloat = 336
    static let HORIZONTAL_SAFE_AREA_INSET: CGFloat = 20

    // contriants
    @IBOutlet weak var keypadStackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var historyContainerViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showHistoryButton: UIButton!
    @IBOutlet weak var historyContainerView: UIView!
    @IBOutlet weak var numberSentenceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // number keypad buttons
    @IBOutlet weak var textKeypadButtonZero: TextKeypadButton!
    @IBOutlet weak var textKeupadButtonOne: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonTwo: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonThree: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonFour: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonFive: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonSix: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonSeven: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonEight: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonNine: IconKeyPadButton!
    
    // operator keypad buttons
    @IBOutlet weak var iconKeypadButtonPositiveNegative: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonPercent: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonDivide: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonMultiply: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonMinus: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonPlus: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonEqual: IconKeyPadButton!
    @IBOutlet weak var iconKeypadButtonDecimal: IconKeyPadButton!
    
    // etc keypad buttons
    @IBOutlet weak var iconKeypadButtonBackspace: IconKeyPadButton!
    @IBOutlet weak var textKeypadButtonCancel: TextKeypadButton!
    
    var disposeBag = DisposeBag()
    private var historyViewController = HistoryViewController()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = MainViewReactor()
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        /// update cgcolors if appearance is changed
        setupShowHistoryButton()
        
        if traitCollection.isLandScapeOniPhone {
            hideHistoryContainerView(false)
        } else if traitCollection.isPortraitOniPhone {
            hideHistoryContainerView(true)
        } else if traitCollection.isPortraitOrLandscapeOniPad {
            if isHistoryContainerViewHidden == false {
                hideHistoryContainerView(false)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureKeypadViewConstraints()
    }

    
    // MARK: - Setup
    
    private func setupView() {
        setupShowHistoryButton()
        setupHistoryViewController()
        setupHistoryContainerView()
    }
    
    private func setupShowHistoryButton() {
        showHistoryButton.layer.cornerRadius = 12
        showHistoryButton.layer.shadowColor = R.color.backgroundColorReversed()?.cgColor
        showHistoryButton.layer.shadowOpacity = 0.1
        showHistoryButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        showHistoryButton.layer.shadowRadius = 20
    }
    
    private func setupHistoryViewController() {
        guard let historyVC = instantiateHistoryViewController() else {
            return
        }
        
        historyVC.delegate = self
        historyViewController = historyVC
    }
    
    private func setupHistoryContainerView() {
        historyViewController.view.translatesAutoresizingMaskIntoConstraints = false
        historyContainerView.addSubview(historyViewController.view)
        historyViewController.view.topAnchor.constraint(equalTo: historyContainerView.topAnchor).isActive = true
        historyViewController.view.leadingAnchor.constraint(equalTo: historyContainerView.leadingAnchor).isActive = true
        historyViewController.view.trailingAnchor.constraint(equalTo: historyContainerView.trailingAnchor).isActive = true
        historyViewController.view.bottomAnchor.constraint(equalTo: historyContainerView.bottomAnchor).isActive = true
        historyViewController.didMove(toParent: self)
    }
    
    
    // MARK: - Configuring
    
    func bind(reactor: MainViewReactor) {
        // Action
        showHistoryButton.rx.tap
            .asDriver()
            .drive(with: self, onNext: { vc, _ in
                vc.presentHistoryVC()
            }).disposed(by: disposeBag)
        
        textKeypadButtonZero.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeupadButtonOne.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonTwo.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(2) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonThree.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(3) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonFour.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(4) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonFive.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(5) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonSix.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(6) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonSeven.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(7) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonEight.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(8) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonNine.rx.tap
            .map { MainViewReactor.Action.didTapNumberKeypad(9) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonPlus.rx.tap
            .map { MainViewReactor.Action.didTapOperator(.addition) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonMinus.rx.tap
            .map { MainViewReactor.Action.didTapOperator(.subtraction) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonMultiply.rx.tap
            .map { MainViewReactor.Action.didTapOperator(.multiplication) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonDivide.rx.tap
            .map { MainViewReactor.Action.didTapOperator(.division) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonDecimal.rx.tap
            .map { MainViewReactor.Action.didTapDecimal }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonPercent.rx.tap
            .map { MainViewReactor.Action.didTapPercent }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        textKeypadButtonCancel.rx.tap
            .map { MainViewReactor.Action.didTapCancel }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonBackspace.rx.tap
            .map { MainViewReactor.Action.didTapBackspace }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonPositiveNegative.rx.tap
            .map { MainViewReactor.Action.didTapPositivieNegative }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        iconKeypadButtonEqual.rx.tap
            .map { MainViewReactor.Action.didTapEqual }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        // State
        reactor.state.map { $0.resultValue }
            .distinctUntilChanged()
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.numberSentence }
            .distinctUntilChanged()
            .bind(with: self, onNext: { vc, newValue in
                vc.numberSentenceLabel.text = newValue
                vc.numberSentenceLabel.makeAsAttributedNumberSentenceLabel(R.color.accentYellow()!, R.color.accentColor()!)
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Methods
    
    private func configureKeypadViewConstraints() {
        if UIDevice.current.userInterfaceIdiom != .pad {
            return
        }
        
        if view.frame.width > DeviceResolution.iPhone_13_ProMax.size.width {
            let safeWidth = view.frame.width - MainViewController.HORIZONTAL_SAFE_AREA_INSET * 2
            keypadStackViewLeadingConstraint.constant = safeWidth - MainViewController.PREFERRED_KEYPAD_WIDTH
        } else {
            keypadStackViewLeadingConstraint.constant = MainViewController.HORIZONTAL_SAFE_AREA_INSET
        }
    }
    
    private func presentHistoryVC() {
        if historyContainerView.frame.width == 0 {
            guard let historyVC = instantiateHistoryViewController() else {
                return
            }
            
            historyVC.delegate = self
            present(historyVC, animated: true)
        } else {
            hideHistoryContainerView(false)
        }
    }
    
    private func instantiateHistoryViewController() -> HistoryViewController? {
        let storyboard = UIStoryboard(name: R.storyboard.history.name, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: R.storyboard.history.historyStoryboard.identifier) as? HistoryViewController else {
            return nil
        }
        
        return viewController
    }
}

extension MainViewController {
    private func hideHistoryContainerView(_ isHidden: Bool) {
        if isHidden {
            historyContainerView.isHidden = true
            showHistoryButton.isHidden = false
        } else {
            historyContainerView.isHidden = false
            showHistoryButton.isHidden = true
        }
    }
    
    private var isHistoryContainerViewHidden: Bool {
        return historyContainerView.isHidden || historyContainerView.frame.width == 0
    }
}

extension MainViewController: HistoryViewDelegate {
    func didTapHideButton() {
        hideHistoryContainerView(true)
    }
    
    func didDismissByTransition() {
        hideHistoryContainerView(false)
    }
}
