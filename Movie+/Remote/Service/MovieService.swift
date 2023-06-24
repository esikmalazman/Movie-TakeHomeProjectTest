//
//  MovieService.swift
//  Movie+
//
//  Created by Ikmal Azman on 23/06/2023.
//

import Foundation

enum MovieService {
    case searchMovieByTitle(query: String)
    case getMovieDetails(id : String)
}

extension MovieService {
    var endpoint : String {
        switch self {
        case .searchMovieByTitle(let query):
            return createEndpoint("search/movie?query=\(query)&")
        case .getMovieDetails(let id) :
            return createEndpoint("movie/\(id)?")
        }
    }
    
    var baseURL : APIProvider {
        switch self {
        default :
            return .movieDB
        }
    }
    
    var apiVersion : APIVersion {
        switch self {
        default :
            return .v3
        }
    }
    
    func createEndpoint(_ endpoint: String) -> String {
        return "\(baseURL.url)/\(apiVersion.rawValue)/\(endpoint)language=en-UK&api_key=\(apiKey)"
    }
}
