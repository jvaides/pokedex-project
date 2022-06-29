//
//  PokemonPokedex.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
struct RegionPokedex:Codable{
    var pokedexes:[RequestResult]?
}

struct PokedexPokemon:Codable{
    var pokemon_entries:[PokemonEntry]?
}

struct PokemonEntry:Codable{
    var entry_number:Int?
    var pokemon_species:RequestResult
}


