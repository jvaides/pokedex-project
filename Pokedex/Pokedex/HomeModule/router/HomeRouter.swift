//
//  HomeRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit
class HomeRouter:HomePresenterToRouterProtocol{
    static func createHomeModule(_ listener:CreateTeamPresenter?) -> HomeViewController {
        
        let view = storyBoard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtrocol = HomeInteracotr()
        let router:HomePresenterToRouterProtocol = HomeRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.chosenRegionAndPokemons = listener
        interactor.presenter = presenter
        
        return view
    }
    
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    func segueToLeagueDetail(leagueInfo: RequestResult,navigationConroller:UINavigationController,_ listener: HomePresenter?) {
        let pokemonList = PokemonsListRouter.createPokemonListModule(listener)
        pokemonList.region = leagueInfo
        navigationConroller.pushViewController(pokemonList, animated: true)
        
    }
    
    
}
