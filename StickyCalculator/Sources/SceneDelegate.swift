//
//  SceneDelegate.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupDefaultUserDefaultsValues()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // TODO: - Save calculation states here
    }
}

extension SceneDelegate {
    private func setupDefaultUserDefaultsValues() {
        UserDefaults.standard.register(defaults: [UserDefaultsKey.visualEffect.rawValue : true])
        UserDefaults.standard.register(defaults: [UserDefaultsKey.recordHistory.rawValue : true])
        UserDefaults.standard.register(defaults: [UserDefaultsKey.theme.rawValue : Appearance.system.rawValue])
    }
}

