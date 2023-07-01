//
//  FavouritesPresenter.swift
//  Movie+
//
//  Created by Ikmal Azman on 01/07/2023.
//

import Foundation

protocol FavouritesPresenterDelegate : AnyObject {
    func renderFavouritesMovie(_ presenter :FavouritesPresenter, didLoadSuccess data : [MovieFavourites])
    func renderFavouritesMovie(_ presenter :FavouritesPresenter, didFailWithError error : Error)
    func refreshFavouriteMovie(_ presenter :FavouritesPresenter)
    func navigateToFavouriteMovieDetailScreen(_ presenter :FavouritesPresenter,  _  data: MovieDetail)
}

final class FavouritesPresenter {
    
    var favouriteList : [MovieFavourites] = []
    var coreDataStack : CoreDataStack = PersistentDelegate.shared.coredataStack
    weak var delegate : FavouritesPresenterDelegate?
    
    func requestFavouritesMovie() {
        coreDataStack.fetchContext(of: MovieFavourites.self, with: [], and: nil) { result in
            
            switch result {
            case .success(let data):
                self.favouriteList = data
                self.delegate?.renderFavouritesMovie(self, didLoadSuccess: self.favouriteList)
            case .failure(let error):
                self.delegate?.renderFavouritesMovie(self, didFailWithError: error)
            }
        }
    }
}

extension FavouritesPresenter {
    func favouriteList(at indexPath: IndexPath) -> Movie {
        let favouriteMovie = favouriteList[indexPath.row]
        let movie = Movie(id: Int(favouriteMovie.id), title: favouriteMovie.title, releaseDate: favouriteMovie.releaseDate, posterPath: favouriteMovie.posterPath)
        return movie
    }
}

extension FavouritesPresenter {
    func openFavouriteMovieList(at indexPath : IndexPath) {
        let favouriteMovie = favouriteList[indexPath.row]
        let movieDetail = MovieDetail(title: favouriteMovie.title, overview: favouriteMovie.overview, releaseDate: favouriteMovie.releaseDate, backdropPath: favouriteMovie.backdropPath)
        delegate?.navigateToFavouriteMovieDetailScreen(self, movieDetail)
    }
    
    func removeFavouriteMovieList(at indexPath: IndexPath) {
        let indexToRemove = indexPath.row
        
        let favouriteMovie = favouriteList[indexToRemove]
        coreDataStack.deleteContext(for: favouriteMovie)
        
        favouriteList.remove(at: indexToRemove)
        delegate?.refreshFavouriteMovie(self)
    }
}
