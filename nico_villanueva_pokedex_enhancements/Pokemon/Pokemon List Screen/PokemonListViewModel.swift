//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Nicks Villanueva on 11/3/22.
//

import Foundation

class PokemonListViewModel {
    
    var morePokemonToLoad = true
    var pokemon = [RemotePokemonListItem]()
    
    init() {
    }
    
    func getNavigationTitle()-> String {
        return "Pokemon"
    }
    
    func fetchMorePokemon(completion: @escaping (Bool) -> ()){
        RemotePokemonDataSource.shared.getPokemonList(offset: pokemon.count) { [weak self] result in
            switch result {
            case .success(let pokemonList):
                DispatchQueue.main.async {
                    self?.pokemonFetchSucceeded(pokemonList: pokemonList)
                    completion(true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func pokemonFetchSucceeded(pokemonList: RemotePokemonList) {
        pokemon.append(contentsOf: pokemonList.results)
        if pokemon.count == pokemonList.count {
            morePokemonToLoad = false
        }
    }
    
    
}
