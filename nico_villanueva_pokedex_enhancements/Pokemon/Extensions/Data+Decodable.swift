//
//  Data+Decodable.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation

extension Data {
    func decodedObject<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: self)
    }
}
