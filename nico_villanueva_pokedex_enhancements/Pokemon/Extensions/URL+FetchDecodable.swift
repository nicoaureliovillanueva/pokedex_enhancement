//
//  URL+FetchDecodable.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation

extension URL {
    func fetch<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: self) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                completion(.success(try data.decodedObject()))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
