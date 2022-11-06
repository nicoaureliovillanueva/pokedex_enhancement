//
//  RemotePokemonListItem.swift
//  Pokemon
//
//  Created by Ben Rosen on 10/10/2022.
//

import Foundation

struct RemotePokemonListItem: Decodable {
    let name: String
    let url: URL

    var id: String? {
        return url.pathComponents.last
    }
}
