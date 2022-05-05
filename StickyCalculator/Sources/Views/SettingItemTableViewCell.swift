//
//  SettingItemTableViewCell.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/04/27.
//

import UIKit

class SettingItemTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        setupSelectionView()
    }
    
    private func setupSelectionView() {
        let selectionView = UIView(frame: self.frame)
        selectionView.backgroundColor = .systemGray5
        selectionView.layer.cornerRadius = 16
        self.selectedBackgroundView = selectionView
    }
}
