//
//  AboutViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

class AboutAppViewController: BaseViewController {
    
    
    // MARK: - Properties
    @IBOutlet weak var appIconImageview: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    typealias Reactor = AboutAppViewReactor
    private var disposeBag = DisposeBag()
    private var reactor: AboutAppViewReactor
    
    
    // MARK: - Initializers
    
    init(_ reactor: AboutAppViewReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    init?(_ coder: NSCoder, _ reactor: AboutAppViewReactor) {
        self.reactor = reactor
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = AboutAppViewReactor()
        setupView()
        bind(reactor: reactor)
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        setupNavigationBar()
        setupAppIconImageView()
        setupHeaderLabel()
    }
    
    private func setupNavigationBar() {
        title = "about".localized()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupAppIconImageView() {
        appIconImageview.image = R.image.appIcon_rounded() ?? UIImage(named: "AppIcon")
        appIconImageview.layer.cornerRadius = 16
    }
    
    private func setupHeaderLabel() {
        headerLabel.text = "\(AppInfo.appName)\nversion \(AppInfo.appVersion)"
    }
    
    
    // MARK: - Configuration
    
    func bind(reactor: AboutAppViewReactor) {
        
    }
}
