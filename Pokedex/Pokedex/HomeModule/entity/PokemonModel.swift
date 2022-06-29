//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation

struct PokemonModel:Codable{
    var count:Int?
    var next:String?
    var previous:String?
    var results:[RequestResult]?
}

struct RequestResult:Codable{
    var name:String?
    var url:String?
}





