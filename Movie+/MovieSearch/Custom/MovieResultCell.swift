//
//  MovieResultCell.swift
//  Movie+
//
//  Created by Ikmal Azman on 23/06/2023.
//

import UIKit

extension MovieResultCell : ReusableXIB {}

final class MovieResultCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.layer.cornerRadius = 5
    }
    
    func configure(_ data : Movie) {
        self.releaseDateLabel.text = data.releaseDate ?? "Release date not available"
        self.titleLabel.text = data.title
        self.thumbnailImageView.downloadImage(fromURLString: data.posterPath ?? "")
    }
}
