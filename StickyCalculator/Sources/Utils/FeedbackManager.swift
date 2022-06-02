//
//  FeedbackGenerator.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/03.
//

import AVFoundation
import UIKit

class FeedbackManager {
    
    enum SystemSound: UInt32 {
        case systemGeneralKeySoundID = 1104
        case systemBackspaceKeySoundID = 1155
    }
    
    enum FeedbackStyle {
        case light
        case selection
    }
    
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    func prepareImpactFeedbackGenerator() {
        lightImpactFeedbackGenerator.prepare()
        selectionFeedbackGenerator.prepare()
    }
    
    func makeHapticFeedback(_ style: FeedbackStyle) {
        switch style {
        case .light:
            lightImpactFeedbackGenerator.impactOccurred()
        case .selection:
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    func makeSoundFeedback(_ soundID: SystemSound) {
        AudioServicesPlaySystemSound(soundID.rawValue)
    }
}
