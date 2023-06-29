//
//  Movie.swift
//  Movie+
//
//  Created by Ikmal Azman on 24/06/2023.
//

import Foundation

struct MovieListResponse : Codable {
    let results : [Movie]?
}

struct Movie : Codable {
    let id : Int?
    let title : String?
    let releaseDate : String?
    let posterPath : String?
}

struct MovieDetail : Codable {
    let title : String?
    let overview : String?
    let releaseDate : String?
    let backdropPath : String?
    let posterPath : String?
}
