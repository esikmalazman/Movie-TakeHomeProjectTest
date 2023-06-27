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
- Add Error handling through Alert
""")

final class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDateTitle: UILabel!
    @IBOutlet weak var overviewDescription: UILabel!
    @IBOutlet weak var addToFavouriteBtn: UIButton!
    
    var presenter : MovieDetailPresenter = MovieDetailPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        
        presenter.delegate = self
        presenter.requestMovieDetails()
    }
    
    func setMovieId(_ id : Int) {
        presenter.setMovieId(id)
    }
}

// MARK:  Actions
extension MovieDetailVC {
    @IBAction func addToFavouriteTapped(_ sender: UIButton) {
    }
}

extension MovieDetailVC : MovieDetailPresenterDelegate {
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didLoadSuccess data: MovieDetail) {
        DispatchQueue.main.async {
            self.configureMovieDetails(data)
        }
    }
    
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didFailWithError error: Error) {
#warning("handle error with alert")
    }
}

extension MovieDetailVC {
    func configureMovieDetails(_ data : MovieDetail) {
        posterImageView.downloadImage(fromURLString: data.backdropPath ?? "", imageSize: .backdrop)
        movieTitle.text = data.title
        movieReleaseDateTitle.text = data.releaseDate
        overviewDescription.text = data.overview
    }
    
    func configureViewAppearance() {
        posterImageView.layer.cornerRadius = 10
        addToFavouriteBtn.layer.cornerRadius = 10
    }
}
