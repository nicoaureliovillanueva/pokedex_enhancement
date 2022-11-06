//
//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Nicks Villanueva on 11/4/22.
//

import XCTest
@testable import Pokemon

class PokemonTests: XCTestCase {
    
    func test_page_title() {
        let viewModel = PokemonListViewModel()
        XCTAssertEqual(viewModel.getNavigationTitle(), "Pokemon")
    }
    
    func test_fetch_pokemon_list_success() {
        let viewModel = PokemonListViewModel()
        viewModel.fetchMorePokemon { success in
            XCTAssertEqual(success, true)
        }
    }
    
    func test_fetch_pokemon_list_invalid() {
        let viewModel = PokemonListViewModel()
        
        viewModel.pokemon = []
        
        viewModel.fetchMorePokemon { failed in
            XCTAssertEqual(failed, false)
        }
    }
    
    func test_valid_pokemon_data() {
        let viewModel = PokemonListViewModel()
        
        if let urlData = URL(string: "https://pokeapi.co/api/v2/pokemon/1/") {
            let rem = RemotePokemonListItem.init(name: "bulbasur", url: urlData)
            
            let pk = RemotePokemonList.init(results: [rem], count: 1)
            
            viewModel.pokemonFetchSucceeded(pokemonList: pk)
            
            XCTAssertNotNil(viewModel.pokemon)
        }
    }
    
    func test_list_pokemon_with_valid_response() {
        if let url = Bundle.main.url(forResource: "PokemonList", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([RemotePokemonListItem].self, from: jsonData)
                print(pokemons)
                XCTAssertEqual(pokemons.count, 3)
            } catch {
                print(error)
            }
        }
    }
}
