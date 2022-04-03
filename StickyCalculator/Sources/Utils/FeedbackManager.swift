//
//  FeedbackGenerator.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import AVFoundation
import UIKit

enum SystemSound: UInt32 {
    case systemGeneralKeySoundID = 1104
    case systemBackspaceKeySoundID = 1155
}

class FeedbackManager {
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func prepareImpactFeedbackGenerator() {
        lightImpactFeedbackGenerator.prepare()
        mediumImpactFeedbackGenerator.prepare()
    }
    
    func makeImpactFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        if style == .light {
            lightImpactFeedbackGenerator.impactOccurred()
        } else {
            mediumImpactFeedbackGenerator.impactOccurred()
        }
    }
    
    func makeSoundFeedback(_ soundID: SystemSound) {
        AudioServicesPlaySystemSound(soundID.rawValue)
    }
}
