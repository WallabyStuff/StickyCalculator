//
//  ToasterView.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/20.
//

import UIKit

extension UIView {
    func makeToast(message: String) {
        let toastView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let messageLabel = UILabel()
        
        
        // ContentView
        toastView.clipsToBounds = false
        toastView.alpha = 0
        toastView.backgroundColor = ToastManager.shared.style.backgroundColor
        toastView.layer.cornerRadius = ToastManager.shared.style.cornerRadius
        toastView.layer.borderWidth = ToastManager.shared.style.borderWidth
        toastView.layer.borderColor = ToastManager.shared.style.borderColor.cgColor
        
        if ToastManager.shared.style.isShadowHidden == false {
            toastView.layer.shadowRadius = ToastManager.shared.style.shadowRadius
            toastView.layer.shadowColor = ToastManager.shared.style.shadowColor.cgColor
            toastView.layer.shadowOffset = ToastManager.shared.style.shadowOffset
            toastView.layer.shadowOpacity = ToastManager.shared.style.shadowOpacity
        }
        
        
        // Message Label
        messageLabel.textColor = ToastManager.shared.style.messageColor
        messageLabel.font = ToastManager.shared.style.font
        messageLabel.text = message
        
        
        // Setup Constraints
        toastView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.centerXAnchor.constraint(equalTo: toastView.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
        
        self.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        toastView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -56).isActive = true
        toastView.widthAnchor.constraint(equalTo: messageLabel.widthAnchor, constant: 24).isActive = true
        toastView.heightAnchor.constraint(equalTo: messageLabel.heightAnchor, constant: 28).isActive = true

        
        // Start fade in
        toastView.fadeIn(duration: 0.2)
        
        
        // Start fade out
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toastView.fadeOut(duration: 0.2) {
                toastView.removeFromSuperview()
            }
        }
    }
}
