//
//  AppInfo.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import Foundation

class AppInfo {
    static var appName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
