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
    var moviesList : [Movie] = []
    
    weak var delegate : MovieSearchPresenterDelegate?
    var movieInteractor : MovieInteractorContract = MovieInteractor()
    
    func requestMovie(for query: String) {
        movieInteractor.fetchMovieTitle(for: query) { result in
            switch result {
            case .success(let data):
                self.moviesList.append(contentsOf: data)
                self.delegate?.renderMovieSearchResults(self, didLoadSuccess: self.moviesList)
#warning("need to consider either need to save error query?")
                self.cacheQueryResults(for: query, with: data)
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

extension MovieSearchPresenter {
#warning("need to check if same query and duplicate data here")
    func cacheQueryResults(for query : String, with results : [Movie]) {
        #warning("might to refactor to use DI so we can test easy later")
        let persistent = AppDelegate.shared.cdStack
        
        let newQueryResult = MovieQuery(context: persistent.context)
        newQueryResult.id = UUID()
        newQueryResult.query = query
        newQueryResult.results = results.binaryData
        
        persistent.saveContext()
    }
}
