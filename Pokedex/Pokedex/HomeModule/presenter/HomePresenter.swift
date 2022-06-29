//
//  HomePresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class HomePresenter:HomeViewToPresenterProtocol{

    
    var chosenRegionAndPokemons: ChooseRegionAndPokemonProtocol?
    
    var view: HomePresenterToViewProtocol?
    
    var interactor: HomePresenterToInteractorProtrocol?
    
    var router: HomePresenterToRouterProtocol?
    
    func requestPokemonLeagues() {
        self.interactor?.getPokemonLeagues()
    }
    
    func showLeagueDetail(leagueInfo: RequestResult,navigationConroller:UINavigationController) {
        router?.segueToLeagueDetail(leagueInfo: leagueInfo, navigationConroller: navigationConroller,self)
    }
    
    func selectedRegion(regionName: String) {
        chosenRegionAndPokemons?.didSelectPokemonAndRegion(region: regionName, pokemons: [])
    }
    
}

extension HomePresenter:HomeInteractorToPresenterProtocol{
    func noticeReceivedLeagues(leagues: PokemonModel) {
        view?.displayPokemonLeagues(leagues: leagues)
    }
    
    func errorReceivedFromApi(error:Error) {
        view?.showError(error: error)
        
    }
    

    
}

extension HomePresenter:ChoosePokemonsProtocol{
    func didSelectPokemons(region: String?, pokemons: [TeamPokemon]?) {
        chosenRegionAndPokemons?.didSelectPokemonAndRegion(region: nil, pokemons: pokemons ?? [])
    }
    
    
}
