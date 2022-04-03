//
//  RoundedButton.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/20.
//

import UIKit

class KeypadButton: UIButton {
    
    @objc
    enum ColorStyle: Int {
        case `default` = 1
        case yellow = 2
        case green = 3
        case distructive = 4
        
        var backgroundColor: UIColor {
            switch self {
            case .default:
                return R.color.backgroundGrayLightest()!
            case .yellow:
                return R.color.accentYellow()!
            case .green:
                return R.color.accentColor()!
            case .distructive:
                return R.color.accentPinkPlaceholder()!
            }
        }
        
        var foregroundColor: UIColor {
            switch self {
            case .default:
                return R.color.textColor()!
            case .yellow:
                return R.color.iconWhite()!
            case .green:
                return R.color.iconWhite()!
            case .distructive:
                return R.color.accentPink()!
            }
        }
    }
    
    static let REGULAR_CORNER_RADIUS_MULTIPLIER: CGFloat = 2.8
    static let COMPACT_CORNER_RADIUS: CGFloat = 18
    private var compactThreshold: CGFloat = 4
    private var _colorStyle: ColorStyle = .default
    var isPressed: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCornerRadius()
    }
    
    private func setupView() {
        if #available(iOS 15.0, *) {
            let config = UIButton(type: .system).configuration
            configuration = config
        }
        
        setupActions()
        configureColor(alpha: 1)
    }
    
    private func setupActions() {
        addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDragInside)
        addTarget(self, action: #selector(buttonReleased(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased(_:)), for: .touchDragOutside)
    }
    
    private func configureColor(alpha: CGFloat) {
        backgroundColor = _colorStyle.backgroundColor.withAlphaComponent(alpha)
        tintColor = _colorStyle.foregroundColor.withAlphaComponent(alpha)
    }
    
    private func configureCornerRadius() {
        if isCompactMode {
            // on compact & compact or regular & compact mode
            cornerRadius = KeypadButton.COMPACT_CORNER_RADIUS
        } else {
            // on regular & regular mode
            cornerRadius = frame.width / KeypadButton.REGULAR_CORNER_RADIUS_MULTIPLIER
        }
    }
    
    func setPressed(_ state: Bool) {
        if state {
            UIView.animate(withDuration: 0.2) {
                self.configureColor(alpha: 0.5)
            }
            
            isPressed = true
        } else {
            UIView.animate(withDuration: 0.2) {
                self.configureColor(alpha: 1)
            }
            
            isPressed = false
        }
    }
}

extension KeypadButton {
    @objc
    private func buttonPressed(_ sender: UIButton) {
        // TODO: -Change color when button pressed
    }
    
    @objc
    private func buttonReleased(_ sender: UIButton) {
        // TODO: - Change color when button released
    }
}


// MARK: - Designs

extension KeypadButton {
    /// This property is just for visualizing on storyboards.
    /// So it is not an actual value and it doesn't work on runtime.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var colorStyle: Int {
        get {
            return self._colorStyle.rawValue
        }
        
        set {
            self._colorStyle = ColorStyle(rawValue: newValue) ?? .default
            configureColor(alpha: 1)
        }
    }
}

extension KeypadButton {
    var isCompactMode: Bool {
        let threshold: CGFloat = 4
        
        if frame.width > frame.height + threshold {
            return true
        } else {
            return false
        }
    }
}
