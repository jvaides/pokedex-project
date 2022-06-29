//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
struct PokemonInformation:Codable{
    /**
            Nombre
     Numero
     Tipo
     Descripcion del pokedex
     Imagen
     **/
    var names:[PokemonNames]?
    var order:Int?
    var genera:[PokemonTypes]?
    var flavor_text_entries:[PokedexDescription]?
}

struct PokemonNames:Codable{
    var name:String
    var language:RequestResult
}

struct PokemonTypes:Codable{
    var genus:String?
    var language:RequestResult
}
struct PokedexDescription:Codable{
    var flavor_text:String?
    var language:RequestResult?
}

struct PokemonImage:Codable{
    var sprites:PokemonSprites?
}
struct PokemonSprites:Codable{
    var front_default:String?
}
