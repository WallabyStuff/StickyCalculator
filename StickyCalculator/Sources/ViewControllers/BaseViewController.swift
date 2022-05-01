//
//  BaseViewController.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
    }
    
    
    // MARK: - Methods
    
    private func configureAppearance() {
        switch Appearance.current {
        case .system:
            self.overrideUserInterfaceStyle = .unspecified
            self.navigationController?.overrideUserInterfaceStyle = .unspecified
        case .light:
            self.overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
        case .dark:
            self.overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
}
