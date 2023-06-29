//
//  RecentsSearchPresenter.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//

import Foundation

protocol RecentsSearchPresenterDelegate : AnyObject {
    func renderCacheQuerySearchResults(_ presenter :RecentsSearchPresenter, didLoadSuccess data : [MovieQuery])
    func renderCacheQuerySearchResults(_ presenter :MovieSearchPresenter, didFailWithError error : Error)
    func refreshCacheQuerySearchResults(_ presenter :RecentsSearchPresenter)
    func navigateToRecentDetailScreen(_ presenter :RecentsSearchPresenter, didTapQuery query : String, _  data: [Movie])
}

final class RecentsSearchPresenter {
    
    var movieQueryList : [MovieQuery] = []
    var coreDataStack : CoreDataStack = AppDelegate.shared.cdStack
    
    weak var delegate : RecentsSearchPresenterDelegate?
    
    func requestCacheSearchQueries() {
        coreDataStack.fetchContext(of: MovieQuery.self, with: []) { result in
            self.movieQueryList = result
            
            self.delegate?.renderCacheQuerySearchResults(self, didLoadSuccess: self.movieQueryList)
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
                print(error.localizedDescription)
#warning("handle error")
            }
        }
        
    }
    
    func removeRecentQueryResults(at indexPath: IndexPath) {
        movieQueryList.remove(at: indexPath.row)
        delegate?.refreshCacheQuerySearchResults(self)
    }
}
