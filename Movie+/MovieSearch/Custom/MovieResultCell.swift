//
//  MovieResultCell.swift
//  Movie+
//
//  Created by Ikmal Azman on 23/06/2023.
//

import UIKit

extension MovieResultCell : ReusableXIB {}

final class MovieResultCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
