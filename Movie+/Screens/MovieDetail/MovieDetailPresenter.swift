//
//  MovieDetailPresenter.swift
//  Movie+
//
//  Created by Ikmal Azman on 26/06/2023.
//

import Foundation

protocol MovieDetailPresenterDelegate : AnyObject {
    func renderMovieDetails(_ presenter :MovieDetailPresenter, didLoadSuccess data : MovieDetail)
    func renderMovieDetails(_ presenter :MovieDetailPresenter, didFailWithError error : Error)
    func saveMovieDetails(_ presenter :MovieDetailPresenter, didTapBookmark bookmarked : Bool)
    func saveMovieDetails(_ presenter :MovieDetailPresenter, didFailToSaveWithError error : Error)
}

final class MovieDetailPresenter {
    
    var movie : Movie?
    var movieDetail : MovieDetail?
    var bookmarked : Bool = false
    
    weak var delegate : MovieDetailPresenterDelegate?
    var movieInteractor : MovieInteractorContract = MovieInteractor()
    var movieStorageInteractor : MovieStorageInteractor = MovieStorageInteractor()
    
    func toggleBookmark() {
        bookmarked.toggle()
        delegate?.saveMovieDetails(self, didTapBookmark: bookmarked)
    }
    
    func requestMovieDetails() {
        movieInteractor.fetchMovieDetails(by: "\(movie?.id ?? 0)") { result in
            switch result {
            case .success(let data):
                self.movieDetail = data
                self.delegate?.renderMovieDetails(self, didLoadSuccess: data)
            case .failure(let error):
                self.delegate?.renderMovieDetails(self, didFailWithError: error)
            }
        }
    }
    
    func saveMovieToFavourites() {
        movieStorageInteractor.saveBookmarked(movie: movie, with: movieDetail) { error in
            self.delegate?.saveMovieDetails(self, didFailToSaveWithError: error)
        }
    }
}

extension MovieDetailPresenter {
    func setMovie(_ movie : Movie) {
        self.movie = movie
    }
}
