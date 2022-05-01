//
//  OptionRowTableViewCell.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/05/01.
//

import UIKit

class OptionRowTableViewCell: SettingItemTableViewCell {

    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    
    // MARK: - Setup
    
    private func setupView() {
        checkImageView.isHidden = true
    }
}
