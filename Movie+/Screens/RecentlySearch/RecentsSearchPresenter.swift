//
//  RecentsSearchPresenter.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//

import Foundation

protocol RecentsSearchPresenterDelegate : AnyObject {
    func renderCacheQuerySearchResults(_ presenter :RecentsSearchPresenter, didLoadSuccess data : [MovieQuery])
    func renderCacheQuerySearchResults(_ presenter :RecentsSearchPresenter, didFailWithError error : Error)
    func refreshCacheQuerySearchResults(_ presenter :RecentsSearchPresenter)
    func navigateToRecentDetailScreen(_ presenter :RecentsSearchPresenter, didTapQuery query : String, _  data: [Movie])
}

final class RecentsSearchPresenter {
    
    var movieQueryList : [MovieQuery] = []
    var coreDataStack : CoreDataStack = PersistentDelegate.shared.coredataStack
    
    weak var delegate : RecentsSearchPresenterDelegate?
    
    func requestCacheSearchQueries() {
        coreDataStack.fetchContext(of: MovieQuery.self, with: [], and: nil) { result in
            
            switch result {
            case .success(let movies):
                self.movieQueryList = movies
                self.delegate?.renderCacheQuerySearchResults(self, didLoadSuccess: self.movieQueryList)
            case .failure(let error):
                self.delegate?.renderCacheQuerySearchResults(self, didFailWithError: error)
            }
        }
    }
}

extension RecentsSearchPresenter {
    func recentQueries(at indexPath : IndexPath) -> MovieQuery {
        let recentQuery = movieQueryList[indexPath.row]
        return recentQuery
    }
}

extension RecentsSearchPresenter {
    func openRecentQueryResults(at indexPath: IndexPath) {
        let recentQuery = movieQueryList[indexPath.row]
        
        guard let data = recentQuery.results else {return}
        
        GeneralUtils.parseData(data, mapper: [Movie].self) { result in
            switch result {
            case .success(let data):
                self.delegate?.navigateToRecentDetailScreen(self, didTapQuery: recentQuery.query ?? "",  data)
            case .failure(let error):
                self.delegate?.renderCacheQuerySearchResults(self, didFailWithError: error)
            }
        }
    }
    
    func removeRecentQueryResults(at indexPath: IndexPath) {
        let indexToRemove = indexPath.row
        
        let queryToRemove = movieQueryList[indexToRemove]
        coreDataStack.deleteContext(for: queryToRemove)
        
        movieQueryList.remove(at: indexToRemove)
        delegate?.refreshCacheQuerySearchResults(self)
    }
}
