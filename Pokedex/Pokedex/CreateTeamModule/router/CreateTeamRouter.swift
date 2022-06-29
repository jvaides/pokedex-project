//
//  CreateTeamRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation

import UIKit

class CreateTeamRouter:CreateTeamPresenterToRouterProtocol{
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    static func createCreateTeamModule() -> CreateTeamViewController {
        let view = storyBoard.instantiateViewController(identifier: "CreateTeamViewController") as! CreateTeamViewController
        let presenter: CreateTeamViewToPresenterProtocol & CreateTeamInteractorToPresenter = CreateTeamPresenter()
        let interactor: CreateTeamPresenterToInteractorProtocol = CreateTeamInteractor()
        let router:CreateTeamPresenterToRouterProtocol = CreateTeamRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func askForPokemons(viewController: UINavigationController, regionName: String?,listener:CreateTeamPresenter?) {
        let pokemonListVC = HomeRouter.createHomeModule(listener)
        pokemonListVC.alreadySelectedRegion = regionName
        viewController.pushViewController(pokemonListVC, animated: true)
        
    }
    
    func dismissViewController(viewController: UINavigationController) {
        viewController.dismiss(animated: true)
    }
    
    
}

