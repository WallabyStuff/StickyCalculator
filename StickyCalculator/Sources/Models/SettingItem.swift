//
//  SettingItem.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/27.
//

import UIKit
import RxSwift

protocol SettingItemType {
    var iconImage: UIImage { get }
    var iconColor: UIColor { get }
    var title: String { get }
    var description: String { get }
}

struct ToggleItem: SettingItemType {
    var iconImage: UIImage
    var iconColor: UIColor
    var title: String
    var description: String
    var userDefaultsKey: UserDefaultsKey
    var actionHandler: (UISwitch, DisposeBag) -> Void
    
    init(iconImage: UIImage,
         iconcolor: UIColor,
         title: String,
         description: String,
         userDefaultsKey: UserDefaultsKey,
         actionHandler: @escaping (UISwitch, DisposeBag) -> Void) {
        self.iconImage = iconImage
        self.iconColor = iconcolor
        self.title = title
        self.description = description
        self.userDefaultsKey = userDefaultsKey
        self.actionHandler = actionHandler
    }
}

struct LinkedItem: SettingItemType {
    var iconImage: UIImage
    var iconColor: UIColor
    var title: String
    var description: String
    var linkHeader: String
    var actionHandler: (UIViewController) -> Void
    
    init(iconImage: UIImage,
         iconcolor: UIColor,
         title: String,
         description: String = "",
         linkHeader: String = "",
         actionHandler: @escaping (UIViewController) -> Void) {
        self.iconImage = iconImage
        self.iconColor = iconcolor
        self.title = title
        self.description = description
        self.linkHeader = linkHeader
        self.actionHandler = actionHandler
    }
}

enum SettingItem: CaseIterable {
    case visualEffect
    case saveHistory
    case theme
    case about
}

extension SettingItem {
    var appearance: SettingItemType {
        switch self {
        case .visualEffect:
            return ToggleItem(iconImage: R.image.flash()!,
                              iconcolor: R.color.itemYellow()!,
                              title: "visual_effect".localized(),
                              description: "visual_effect.desc".localized(),
                              userDefaultsKey: .visualEffect) { toggleSwitch, disposeBag in
                toggleSwitch.rx.isOn
                    .asDriver()
                    .drive(onNext: { bool in
                        UserDefaults.standard.set(bool, forKey: UserDefaultsKey.visualEffect.rawValue)
                    }).disposed(by: disposeBag)
            }
        case .saveHistory:
            return ToggleItem(iconImage: R.image.folder()!,
                              iconcolor: R.color.itemMint()!,
                              title: "record_history".localized(),
                              description: "record_history.desc".localized(),
                              userDefaultsKey: .recordHistory,
                              actionHandler: { toggleSwitch, disposeBag in
                toggleSwitch.rx.isOn
                    .asDriver()
                    .drive(onNext: { bool in
                        UserDefaults.standard.set(bool, forKey: UserDefaultsKey.recordHistory.rawValue)
                    }).disposed(by: disposeBag)
            })
        case .theme:
            return LinkedItem(iconImage: R.image.paintBrush()!,
                              iconcolor: R.color.itemRed()!,
                              title: "appearance".localized(),
                              linkHeader: Appearance.current.title,
                              actionHandler: { vc in
                let storyboard = UIStoryboard(name: R.storyboard.setting.name, bundle: nil)
                let destVC = storyboard.instantiateViewController(identifier: R.storyboard.setting.themeSelectorStoryboard.identifier) { coder -> AppearanceSelectorViewController in
                    let reactor = AppearnaceSelectorViewReactor()
                    return .init(coder, reactor) ?? AppearanceSelectorViewController(.init())
                }
                
                destVC.delegate = vc as? AppearanceSelectorViewDelegate
                vc.navigationController?.pushViewController(destVC, animated: true)
            })
        case .about:
            return LinkedItem(iconImage: R.image.info()!,
                              iconcolor: R.color.itemBlue()!,
                              title: "about".localized(),
                              actionHandler: { vc in
                let storyboard = UIStoryboard(name: R.storyboard.setting.name, bundle: nil)
                let destVC = storyboard.instantiateViewController(identifier: R.storyboard.setting.aboutAppStoryboard.identifier) { coder -> AboutAppViewController in
                    let reactor = AboutAppViewReactor()
                    return .init(coder, reactor) ?? AboutAppViewController(.init())
                }
                
                vc.navigationController?.pushViewController(destVC, animated: true)
            })
        }
    }
}
