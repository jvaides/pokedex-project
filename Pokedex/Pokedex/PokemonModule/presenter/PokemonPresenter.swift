//
//  PokemonPresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class PokemonPresenter:PokemonViewToPresenterProtocol{

    
    var favoritedPokemonProtocol: FavoritedPokemonProtocol?
    
    var view: PokemonPresenterToViewProtocol?
    
    var interactor: PokemonPresenterToInteractorProtocol?
    
    var router: PokemonPresenterToRouterProtocol?
    
    func getPokemonImage(orderNumber: Int) {
        interactor?.getPokemonImage(orderNumber: orderNumber)
    }
    
    func addPokemonToTeam(pokemon: TeamPokemon,navigationController:UINavigationController) {
        favoritedPokemonProtocol?.didSelectPokemon(pokemon: pokemon)
        router?.didSelectPokemonForTeam(navigationController: navigationController)
        
    }
    
    
}

extension PokemonPresenter:PokemonInteractorToPresenterProtocol{
    func didFinishLoadingImage(imageData: Data, imageUrl: String) {
        view?.displayPokemonImage(imageData: imageData,imageUrl: imageUrl)
    }
    
    func didFinishWithError(error:Error) {
        view?.showError(error: error)
    }
    
    
}


