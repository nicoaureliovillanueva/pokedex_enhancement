//
//  RemotePokemonDataSource.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation

class RemotePokemonDataSource {

    enum Error: Swift.Error {
        case couldNotCreateUrl
    }

    static let shared = RemotePokemonDataSource()

    private let baseURLPath = "https://pokeapi.co/api/v2/"

    private lazy var baseURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/"
        return urlComponents
    }()

    func getPokemonList(offset: Int = 0, limit: Int = 20, completion: @escaping (Result<RemotePokemonList, Swift.Error>) -> Void) {
        var urlComponents = baseURLComponents
        urlComponents.path.append("pokemon")
        urlComponents.queryItems = [URLQueryItem(name: "offset", value: String(offset)),
                                    URLQueryItem(name: "limit", value: String(limit))]

        guard let url = urlComponents.url else {
            completion(Result.failure(Error.couldNotCreateUrl))
            return
        }

        url.fetch(completion: completion)
    }

    func getPokemonDetails(id: String, completion: @escaping (Result<RemotePokemonDetails, Swift.Error>) -> Void) {
        var urlComponents = baseURLComponents
        urlComponents.path.append("pokemon/\(id)/")

        guard let url = urlComponents.url else {
            completion(Result.failure(Error.couldNotCreateUrl))
            return
        }

        url.fetch(completion: completion)
    }

}
