//
//  PokemonsListInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
class PokemonsListInteractor:PokemonsListPresenterToInteractorProtocol{
    var presenter: PokemonsListInteractorToPresenterProtocol?
    fileprivate var pokemons:[PokemonInformation] = []
    fileprivate var pokedexpokemons:PokedexPokemon?
    
    func getRegionPokedex(region: RequestResult) {
        let url = POKEMON_API_V2+POKEMON_REGIONS_BASE+(region.name ?? "kanto")
        NetworkService.GetPokedexInformation(url:url , objectDecode: RegionPokedex.self) { dictionary, error in
            if error == nil{
                let multiPokedex = dictionary as! RegionPokedex
                self.getPokedexInfo(pokedex: multiPokedex.pokedexes?.first ?? RequestResult(name: "kanto", url: "https://pokeapi.co/api/v2/pokedex/2/"))
            }else{
                self.presenter?.didFinishWithError(error: error!)
            }
            
        }
    }
    
    fileprivate func getPokedexInfo(pokedex:RequestResult){
        NetworkService.GetPokedexInformation(url: pokedex.url ?? "https://pokeapi.co/api/v2/pokedex/2/", objectDecode: PokedexPokemon.self) { dictionary, error in
            if error == nil{
                let pokedex = dictionary as! PokedexPokemon
                self.pokedexpokemons = pokedex
                for pokemon in pokedex.pokemon_entries ?? [] {
                    self.getPokemonInformation(pokemon: pokemon.pokemon_species)
                }
            }else{
                self.presenter?.didFinishWithError(error: error!)
            }
        }
    }
    fileprivate func getPokemonInformation(pokemon:RequestResult){
        NetworkService.GetPokedexInformation(url: pokemon.url ?? "https://pokeapi.co/api/v2/pokemon-species/1/", objectDecode: PokemonInformation.self) { dictionary, error in
            if error == nil{
                let information = dictionary as! PokemonInformation
                self.pokemons.append(information)
                if self.pokedexpokemons?.pokemon_entries?.count == self.pokemons.count{
                    self.presenter?.didFinishCreatingPokedex(processedPokedex: self.pokemons)
                }
            }else{
                //self.presenter?.didFinishWithError(error: error!)
            }

        }
    }
}
