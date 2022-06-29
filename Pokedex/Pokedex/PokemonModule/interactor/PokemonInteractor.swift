//
//  PokemonInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation

class PokemonInteractor:PokemonPresenterToInteractorProtocol{
    var presenter: PokemonInteractorToPresenterProtocol?
    func getPokemonImage(orderNumber: Int) {
        NetworkService.GetPokedexInformation(url: POKEMON_API_V2+POKEMON_GENERAL_INFO+"\(orderNumber)", objectDecode: PokemonImage.self) { dictionary, error in
            if error == nil{
                let pokemonImage = dictionary as! PokemonImage
                NetworkService.GetPokemonImage(url: pokemonImage.sprites?.front_default ?? "") { file, error in
                    if error == nil{
                        self.presenter?.didFinishLoadingImage(imageData: file as! Data,imageUrl: (pokemonImage.sprites?.front_default)!)
                    }else{
                        self.presenter?.didFinishWithError(error: error!)
                    }
                    
                }
            }
        }
    }
    
    
}
