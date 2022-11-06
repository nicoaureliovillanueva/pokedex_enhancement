//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Nicks Villanueva on 11/4/22.
//

import Foundation

class PokemonDetailsViewModel {
    
    var pokemonID: String?
    
    var pokemonName: String?
    var types: String?
    var weight: Int?
    var height: Int?
    var image: URL!
    
    init(id: String) {
        self.pokemonID = id
    }
    
    func fetchPokemonDetails(completion: @escaping (Bool) -> ()) {
        
        guard let id = self.pokemonID else { return }
        
        RemotePokemonDataSource.shared.getPokemonDetails(id: id) { [weak self] result in

            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self?.pokemonFetchDetailSucceeded(details: details)
                    completion(true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    print("error")
                    completion(false)
                }
            }
        }
    }
    
    func pokemonFetchDetailSucceeded(details: RemotePokemonDetails) {

        self.pokemonName = details.name.capitalized
        
        let types = details.types.map({ type in
            type.type.name.capitalized
        }).joined(separator: ", ")
        
        self.types = types
        
        self.weight = details.weight
        self.height = details.height
        self.image = details.sprites.frontDefault
    }
    
    func getPokemonName()-> String {
        return self.pokemonName ?? ""
    }
    
    func getTypes()-> String {
        return "Types: \(self.types ?? "")"
        
    }
    
    func getWeight()-> String {
        guard let weight = self.weight else { return "Unknown" }
        return "Weight: \(weight)kg"
    }
    
    func getHeight()-> String {
        guard let height = self.height else { return "Unknown" }
        return "Height: \(height)cm"
    }
    
    func getPokemonImage()-> URL {
        return self.image
    }

    
}
