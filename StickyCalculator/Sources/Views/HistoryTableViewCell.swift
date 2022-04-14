//
//  HistoryTableViewCell.swift
//  StickyCalculator
//
//  Created by 이승기 on 2022/03/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberSentenceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        numberSentenceLabel.text = ""
        dateTimeLabel.text = ""
        resultLabel.text = ""
    }
}
