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
    
    func setMovieDetail(_ movie : Movie) {
        presenter.setMovie(movie)
    }
}

// MARK:  Actions
extension MovieDetailVC {
#warning("save favourites in Core Data")
    @IBAction func addToFavouriteTapped(_ sender: UIButton) {
        presenter.saveMovieToFavourites()
    }
}

extension MovieDetailVC : MovieDetailPresenterDelegate {
    func saveMovieDetails(_ presenter: MovieDetailPresenter, isBoomarkSaved: Bool) {
        showBookmarkMovieSuccessAlert()
    }
    
    func saveMovieDetails(_ presenter: MovieDetailPresenter, isBoomarkSaved: Bool, didFailWithError error: Error) {
        showBookmarkMovieErrorAlert(error)
    }
    
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didLoadSuccess data: MovieDetail) {
        DispatchQueue.main.async {
            self.configureMovieDetails(data)
        }
    }
    
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didFailWithError error: Error) {
        showRequestMovieDetailErrorAlert(error)
    }
}

extension MovieDetailVC {
    func configureMovieDetails(_ data : MovieDetail) {
        posterImageView.downloadImage(fromURLString: data.backdropPath ?? "", imageSize: .backdrop)
        posterImageView.layoutIfNeeded()
        
        movieTitle.text = data.title
        movieReleaseDateTitle.text = data.releaseDate
        overviewDescription.text = data.overview
    }
    
    func configureViewAppearance() {
        posterImageView.layer.cornerRadius = 10
        addToFavouriteBtn.layer.cornerRadius = 10
        addToFavouriteBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    }
    
    func showRequestMovieDetailErrorAlert(_ error : Error) {
        let alert = showErrorAlert(error.localizedDescription) {
            self.presenter.requestMovieDetails()
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showBookmarkMovieErrorAlert(_ error : Error) {
        let alert = showErrorAlert(error.localizedDescription) {
            self.presenter.saveMovieToFavourites()
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showBookmarkMovieSuccessAlert() {
        let alert = showSuccessAlert("Woohoo!", "Movie succefully add to bookmarks")
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
