//
//  RecentsCell.swift
//  Movie+
//
//  Created by Ikmal Azman on 01/07/2023.
//

import UIKit

extension RecentCell : ReusableXIB{}

final class RecentCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var recentTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewAppearance()
    }
    
    func configure(_ data : MovieQuery) {
        recentTitleLabel.text = data.query
        dateLabel.text = data.date
    }
}

private extension RecentCell {
    func setupViewAppearance() {
        selectionStyle = .none
        
        baseView.layer.cornerRadius = 5
        
        let padding = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        contentView.layoutMargins = padding
    }
}
