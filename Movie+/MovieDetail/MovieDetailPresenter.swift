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
}

final class MovieDetailPresenter {
    
    var movieId : Int = 0
    weak var delegate : MovieDetailPresenterDelegate?
    var movieInteractor : MovieInteractorContract = MovieInteractor()
    
    func requestMovieDetails() {
        movieInteractor.fetchMovieDetails(by: "\(movieId)") { result in
            switch result {
            case .success(let data):
                print(data)
                self.delegate?.renderMovieDetails(self, didLoadSuccess: data)
            case .failure(let error):
                print(error)
                self.delegate?.renderMovieDetails(self, didFailWithError: error)
            }
        }
    }
}

extension MovieDetailPresenter {
    func setMovieId(_ id : Int) {
        self.movieId = id
    }
}
