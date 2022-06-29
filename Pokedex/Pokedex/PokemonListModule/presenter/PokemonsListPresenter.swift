//
//  PokemonsListPresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class PokemonsListPresenter:PokemonsListViewToPresenterProtocol{
    var selectedPokemonsProtocol: ChoosePokemonsProtocol?
    
    var view: PokemonsListPresenterToViewProtocol?
    
    var interactor: PokemonsListPresenterToInteractorProtocol?
    
    var router: PokemonsListPresenterToRouterProtocol?
    
    fileprivate var selectedPokemons:[TeamPokemon] = []
    
    func getRegionPokedex(region: RequestResult) {
        interactor?.getRegionPokedex(region: region)
    }
    
    func showPokemonInformation(pokemon: PokemonInformation, navigationController: UINavigationController) {
        router?.segueToPokemonInformation(pokemon: pokemon, navigationController: navigationController, self)
    }
    
}

extension PokemonsListPresenter:PokemonsListInteractorToPresenterProtocol{
    func didFinishCreatingPokedex(processedPokedex: [PokemonInformation]) {
        view?.displayRegionPokedex(processedPokedex: processedPokedex)
    }
    
    func didFinishWithError(error:Error) {
        view?.showError(error: error)
    }
    
    
}

extension PokemonsListPresenter:FavoritedPokemonProtocol{
    func didSelectPokemon(pokemon: TeamPokemon) {
        self.selectedPokemons.append(pokemon)
        self.selectedPokemonsProtocol?.didSelectPokemons(region: nil, pokemons: self.selectedPokemons)
    }
    
    
}
