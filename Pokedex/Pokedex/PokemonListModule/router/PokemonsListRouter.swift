//
//  PokemonsListRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class PokemonsListRouter:PokemonsListPresenterToRouterProtocol{
    
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    
    static func createPokemonListModule(_ listener: HomePresenter?) -> PokemonsListViewController {
        let view = storyBoard.instantiateViewController(identifier: "PokemonsListViewController") as! PokemonsListViewController
        let presenter: PokemonsListViewToPresenterProtocol & PokemonsListInteractorToPresenterProtocol = PokemonsListPresenter()
        let interactor: PokemonsListPresenterToInteractorProtocol = PokemonsListInteractor()
        let router:PokemonsListPresenterToRouterProtocol = PokemonsListRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.selectedPokemonsProtocol = listener
        interactor.presenter = presenter
        
        return view
    }
    
    func segueToPokemonInformation(pokemon: PokemonInformation,navigationController:UINavigationController,_ listener:PokemonsListPresenter?) {
        let pokemonView = PokemonRouter.createPokemonModule(listener)
        pokemonView.pokemon = pokemon
        navigationController.pushViewController(pokemonView, animated: true)
    }
    
    
}
