//
//  MovieDetailVC.swift
//  Movie+
//
//  Created by Ikmal Azman on 22/06/2023.
//

import UIKit

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
    }
    
    func requestMovieDetail(for movie : Movie) {
        presenter.setMovie(movie)
        presenter.delegate = self
        presenter.requestMovieDetails()
    }
    
    func configure(_ data : MovieDetail, shouldHideBookmark state: Bool = false) {
        posterImageView.downloadImage(fromURLString: data.backdropPath ?? "", imageSize: .backdrop)
        
        movieTitle.text = data.title
        movieReleaseDateTitle.text = data.releaseDate
        overviewDescription.text = data.overview
        
        addToFavouriteBtn.isHidden = state
    }
}

// MARK:  Actions
extension MovieDetailVC {
    @IBAction func addToFavouriteTapped(_ sender: UIButton) {
        presenter.toggleBookmark()
        presenter.saveMovieToFavourites()
    }
}

extension MovieDetailVC : MovieDetailPresenterDelegate {
    func saveMovieDetails(_ presenter: MovieDetailPresenter, didFailToSaveWithError error: Error) {
        showBookmarkMovieErrorAlert(error)
    }
    
    func saveMovieDetails(_ presenter: MovieDetailPresenter, didTapBookmark isBoomarkSaved: Bool) {
        configureBookmarkState(presenter.bookmarked)
        showBookmarkMovieSuccessAlert()
    }
    
    func saveMovieDetails(_ presenter: MovieDetailPresenter, isBoomarkSaved: Bool, didFailWithError error: Error) {
        showBookmarkMovieErrorAlert(error)
    }
    
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didLoadSuccess data: MovieDetail) {
        DispatchQueue.main.async {
            self.configure(data)
        }
    }
    
    func renderMovieDetails(_ presenter: MovieDetailPresenter, didFailWithError error: Error) {
        showRequestMovieDetailErrorAlert(error)
    }
}

private extension MovieDetailVC {
    func configureViewAppearance() {
        posterImageView.layer.cornerRadius = 10
        addToFavouriteBtn.layer.cornerRadius = 10
        addToFavouriteBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        configureBookmarkState(presenter.bookmarked)
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
        guard presenter.bookmarked else {return}
        
        let alert = showSuccessAlert("Woohoo!", "Movie succefully add to bookmarks")
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func configureBookmarkState(_ state : Bool) {
        let image = UIImage(systemName: state ? SFImage.bookmarked.name : SFImage.bookmark.name)
        addToFavouriteBtn.setImage(image, for: .normal)
        
        if state {
            setAddFavouriteButton(backgroundColor: .systemIndigo, borderColor: .clear, tintColor: .white)
        } else {
            setAddFavouriteButton(backgroundColor: .white, borderColor: .systemIndigo, tintColor: .systemIndigo)
        }
    }
    
    func setAddFavouriteButton(backgroundColor : UIColor, borderColor : UIColor, tintColor : UIColor) {
        addToFavouriteBtn.backgroundColor = backgroundColor
        addToFavouriteBtn.layer.borderColor = borderColor.cgColor
        addToFavouriteBtn.layer.borderWidth = 1
        addToFavouriteBtn.tintColor = tintColor
        addToFavouriteBtn.setTitleColor(tintColor, for: .normal)
    }
}
