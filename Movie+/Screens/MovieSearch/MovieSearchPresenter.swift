//
//  MovieSearchPresenter.swift
//  Movie+
//
//  Created by Ikmal Azman on 25/06/2023.
//

import Foundation

protocol MovieSearchPresenterDelegate : AnyObject {
    func renderMovieSearchResults(_ presenter :MovieSearchPresenter, didLoadSuccess data : [Movie])
    func renderMovieSearchResults(_ presenter :MovieSearchPresenter, didFailWithError error : Error)
    func navigateToMovieDetailScreen(_ presenter :MovieSearchPresenter, didTapMovie movieId : Int)
}

final class MovieSearchPresenter {
#warning("Empty it once ready to implement Core Data")
    var recentlySearchQueries : [String] = [
        "Recent 1",
        "Recent 2"
    ]
    
    var moviesList : [Movie] = []
    
    weak var delegate : MovieSearchPresenterDelegate?
    var movieInteractor : MovieInteractorContract = MovieInteractor()
    
    func requestMovie(for query: String) {
        movieInteractor.fetchMovieTitle(for: query) { result in
            switch result {
            case .success(let data):
                self.moviesList.append(contentsOf: data)
                self.delegate?.renderMovieSearchResults(self, didLoadSuccess: self.moviesList)
            case .failure(let error):
                self.delegate?.renderMovieSearchResults(self, didFailWithError: error)
            }
        }
    }
    
    func clearMovieList() {
        moviesList = []
    }
}

extension MovieSearchPresenter {
    func insertRecentlySearchQueries(_ query : String) {
        recentlySearchQueries.append(query)
    }
    
    func selectMovie(at index : Int) {
        let selectedMovie = moviesList[index]
        delegate?.navigateToMovieDetailScreen(self, didTapMovie: selectedMovie.id ?? 0)
    }
}

extension MovieSearchPresenter {
    func movie(at index : Int) -> Movie {
        let movie = moviesList[index]
        return movie
    }
}
