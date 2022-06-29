//
//  PokemonRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class PokemonRouter:PokemonPresenterToRouterProtocol{
    func didSelectPokemonForTeam(navigationController: UINavigationController) {
        navigationController.popToRootViewController(animated: true)
    }
    
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    static func createPokemonModule(_ listener: PokemonsListPresenter?) -> PokemonViewController {
        let view = storyBoard.instantiateViewController(identifier: "PokemonViewController") as! PokemonViewController
        let presenter: PokemonViewToPresenterProtocol & PokemonInteractorToPresenterProtocol = PokemonPresenter()
        let interactor: PokemonPresenterToInteractorProtocol = PokemonInteractor()
        let router:PokemonPresenterToRouterProtocol = PokemonRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.favoritedPokemonProtocol = listener
        interactor.presenter = presenter
        
        return view
    }
    
    
}
