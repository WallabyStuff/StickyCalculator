//
//  AboutViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

class AboutAppViewController: BaseViewController, View {
    
    
    // MARK: - Properties
    @IBOutlet weak var appIconImageview: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    typealias Reactor = AboutAppViewReactor
    var disposeBag = DisposeBag()
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reactor = AboutAppViewReactor()
        setupView()
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
