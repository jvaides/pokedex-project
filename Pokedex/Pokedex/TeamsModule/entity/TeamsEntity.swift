//
//  TeamsEntity.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
struct TeamsEntity:Codable{
    var teams:[TeamInfo]?
}

struct TeamInfo:Codable{
    var team_id:String?
    var team_user_access:[UserAccess]?
    var pokemons:[TeamPokemon]?
    var region:String?
    var name:String?
    var user:String?
}

struct UserAccess:Codable{
    var user_id:String?
}

struct TeamPokemon:Codable{
    var name:String?
    var species_url:String?
    var pokemon_url:String?
    var pokemon_image:String?
    var order:Int?
}
