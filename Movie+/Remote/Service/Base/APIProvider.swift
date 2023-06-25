//
//  APIProvider.swift
//  Movie+
//
//  Created by Ikmal Azman on 23/06/2023.
//

import Foundation

enum APIProvider {
    case movieDB
    case imageDB
}

extension APIProvider {
    var url : String {
        switch self {
        case .movieDB:
            return "https://api.themoviedb.org"
        case .imageDB:
            return "https://image.tmdb.org/t/p"
        }
    }
}

enum APIVersion : String {
    case v3 = "3"
}
