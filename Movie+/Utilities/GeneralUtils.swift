//
//  GeneralUtils.swift
//  Movie+
//
//  Created by Ikmal Azman on 29/06/2023.
//

import Foundation

final class GeneralUtils {
    
    static func parseData<T:Decodable>(_ data : Data, mapper : T.Type, _ completion : @escaping (Result<T, Error>)->Void) {
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let object = try decoder.decode(mapper.self, from: data)
            completion(.success(object))
        } catch {
            completion(.failure(error))
        }
    }
    
    static func encodeData<T:Encodable>(_ data : T, _ completion : @escaping (Result<Data, Error>)->Void) {
        
        do {
            let encoder = JSONEncoder()
            
            let object = try encoder.encode(data)
            completion(.success(object))
        } catch {
            completion(.failure(error))
        }
    }
}
