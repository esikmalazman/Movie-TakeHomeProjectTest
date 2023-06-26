//
//  MovieDetailVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 22/06/2023.
//

import UIKit

#warning("""
Todo's
1. Display selected movie from search results
- Setup UI for Movie Information ✅
- Add option to save movie in favourites, save through Core Data (Bonus)
""")

final class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDateTitle: UILabel!
    @IBOutlet weak var overviewDescription: UILabel!
    @IBOutlet weak var addToFavouriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.layer.cornerRadius = 10
        addToFavouriteBtn.layer.cornerRadius = 10
    }
}

// MARK:  Actions
extension MovieDetailVC {
    @IBAction func addToFavouriteTapped(_ sender: UIButton) {
    }
}
