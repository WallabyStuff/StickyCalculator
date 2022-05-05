//
//  ToggleSettingItemTableViewCell.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/27.
//

import UIKit

class SwitchRowTableViewCell: SettingItemTableViewCell {

    @IBOutlet weak var iconContentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    private func setupView() {
        setupIconContentView()
    }
    
    private func setupIconContentView() {
        iconContentView.layer.cornerRadius = 12
    }
}
