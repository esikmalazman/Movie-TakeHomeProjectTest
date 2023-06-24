//
//  MovieInteractor.swift
//  Movie+
//
//  Created by Ikmal Azman on 24/06/2023.
//

import Foundation

protocol MovieInteractorContract {
    var client : HttpClient {get set}
    func fetchMovieTitle(for query : String, completion: @escaping (Result<[Movie], Error>) ->  Void)
    func fetchMovieDetails(by movieId : String, completion: @escaping (Result<MovieDetail, Error>) ->  Void)
}

final class MovieInteractor : MovieInteractorContract {
    
    var client : HttpClient
    
    init(client: HttpClient = .init()) {
        self.client = client
    }
    
    func fetchMovieTitle(for query : String, completion: @escaping (Result<[Movie], Error>) ->  Void) {
        
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        guard let url = URL(string: MovieService.searchMovieByTitle(query: query).endpoint) else {
            return
        }
        
        let request = URLRequest(url: url)
        client.requestData(for: request, mapper: MovieListResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data.results ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(by movieId : String, completion: @escaping (Result<MovieDetail, Error>) ->  Void) {
        
        guard let url = URL(string: MovieService.getMovieDetails(id: movieId).endpoint) else {
            return
        }
        
        let request = URLRequest(url: url)
        client.requestData(for: request, mapper: MovieDetail.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
