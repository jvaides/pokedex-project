//
//  HomeInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
class HomeInteracotr:HomePresenterToInteractorProtrocol{
    var presenter: HomeInteractorToPresenterProtocol?
    
    func getPokemonLeagues() {
        NetworkService.GetPokedexInformation(url: POKEMON_API_V2+POKEMON_REGIONS_BASE,objectDecode: PokemonModel.self) { dictionary, error in
            if error == nil{
                self.presenter?.noticeReceivedLeagues(leagues: dictionary as! PokemonModel)
            }else{
                self.presenter?.errorReceivedFromApi(error: error!)
            }
        }
    }
    
    
}
