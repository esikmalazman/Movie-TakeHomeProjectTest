//
//  MovieStorageInteractor.swift
//  Movie+
//
//  Created by Ikmal Azman on 01/07/2023.
//

import Foundation

protocol MovieStorageInteractorContract {
    func saveSearch(for query : String, with results : [Movie], _ completion : @escaping (Result<(), Error>)->Void)
    func fetchSavedSearch(_ completion : @escaping (Result<[MovieQuery], Error>)->Void)
    func deleteSelectedSearch(_ query : MovieQuery)
    func saveBookmarked(movie : Movie?, with detail : MovieDetail?, _ errorClosure : @escaping (Error) -> Void)
    func fetchBookmarkedMovie(_ completion : @escaping (Result<[MovieFavourites],Error>)->Void)
    func deleteSelectedBookmarkedMovie(_ movie : MovieFavourites)
}

final class MovieStorageInteractor : MovieStorageInteractorContract {
    
    let persistent : CoreDataStack
    
    init(persistent: CoreDataStack = PersistentDelegate.shared.coredataStack) {
        self.persistent = persistent
    }
    
    func saveSearch(for query : String, with results : [Movie], _ completion : @escaping (Result<(), Error>)->Void) {
        let newSearchResult = MovieQuery(context: persistent.context)
        newSearchResult.id = UUID()
        newSearchResult.query = query.lowercased()
        
        let searchDate = Date().toMonthDayTimeFormat
        newSearchResult.date = searchDate
        
        GeneralUtils.encodeData(results) { data in
            switch data {
            case .success(let data):
                newSearchResult.results = data
                self.persistent.saveContext()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSavedSearch(_ completion : @escaping (Result<[MovieQuery], Error>)->Void) {
        persistent.fetchContext(of: MovieQuery.self, with: [], and: nil) { result in
            
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteSelectedSearch(_ query : MovieQuery) {
        persistent.deleteContext(for: query)
    }
    
    func saveBookmarked(movie : Movie?, with detail : MovieDetail?, _ errorClosure : @escaping (Error) -> Void) {
        let movieFavourites = MovieFavourites(context: persistent.context)
        movieFavourites.id = Int32(movie?.id ?? 0)
        movieFavourites.title = movie?.title
        movieFavourites.releaseDate = movie?.releaseDate
        movieFavourites.posterPath = movie?.posterPath
        movieFavourites.overview = detail?.overview
        movieFavourites.backdropPath = detail?.backdropPath
        persistent.saveContext { error in
            guard let error = error else {return}
            errorClosure(error)
        }
    }
    
    func fetchBookmarkedMovie(_ completion : @escaping (Result<[MovieFavourites],Error>)->Void) {
        persistent.fetchContext(of: MovieFavourites.self, with: [], and: nil) { result in
            
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteSelectedBookmarkedMovie(_ movie : MovieFavourites) {
        persistent.deleteContext(for: movie)
    }
}
