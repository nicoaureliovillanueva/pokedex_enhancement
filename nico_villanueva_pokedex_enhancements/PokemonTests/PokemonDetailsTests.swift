//
//  PokemonDetailsTests.swift
//  PokemonTests
//
//  Created by Nicks Villanueva on 11/4/22.
//

import XCTest
@testable import Pokemon

class PokemonDetailsTests: XCTestCase {
    
    func test_pokemon_detail_with_valid_response() {
        if let url = Bundle.main.url(forResource: "PokemonDetail", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemonDetail = try decoder.decode(RemotePokemonDetails.self, from: jsonData)
                
                XCTAssertEqual(pokemonDetail.name, "bulbasaur")
                XCTAssertEqual(pokemonDetail.weight, 69)
                XCTAssertEqual(pokemonDetail.height, 7)
                XCTAssertEqual(pokemonDetail.types.count, 2)
                XCTAssertNotNil(pokemonDetail.sprites.frontDefault)
            } catch {
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_configure_date_when_detail_succeeded() {
        
        let viewModel = PokemonDetailsViewModel(id: "1")
        
        let types = RemotePokemonType.init(slot: 1,
                                           type: RemotePokemonTypeResource(name: "grass"))
        
        let sprites = RemotePokemonSprites.init(frontDefault: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!)
        
        let pokemonDetails = RemotePokemonDetails.init(name: "bulbasaur",
                                                       weight: 69,
                                                       height: 7,
                                                       types: [types],
                                                       sprites: sprites)
        
        viewModel.pokemonFetchDetailSucceeded(details: pokemonDetails)
        
        
        XCTAssertEqual(viewModel.getPokemonName(), "Bulbasaur")
        XCTAssertEqual(viewModel.getTypes(), "Types: Grass")
        XCTAssertEqual(viewModel.getWeight(), "Weight: 69kg")
        XCTAssertEqual(viewModel.getHeight(), "Height: 7cm")
        XCTAssertNotNil(viewModel.getPokemonImage())
        
    }
    
    func test_get_pokemon_details() {
        let viewModel = PokemonDetailsViewModel(id: "1")
        
        let expectation = self.expectation(description: "Pokemon Details")
        
        viewModel.fetchPokemonDetails { success in
            expectation.fulfill()
            XCTAssertEqual(success, true)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
}
