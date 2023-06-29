//
//  HttpClient.swift
//  Movie+
//
//  Created by Ikmal Azman on 24/06/2023.
//

import Foundation

final class HttpClient {
    
    let session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestData<T:Decodable>(for request : URLRequest, mapper : T.Type ,_ completion : @escaping (Result<T, Error>)->Void) {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completion(.failure(NSError(domain: "HttpError", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Data", code: 1)))
                return
            }
            
            GeneralUtils.parseData(data, mapper: mapper, completion)
        }
        
        task.resume()
    }
}
