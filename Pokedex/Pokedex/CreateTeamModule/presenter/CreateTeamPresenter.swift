//
//  CreateTeamPresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation

import UIKit

class CreateTeamPresenter:CreateTeamViewToPresenterProtocol{

    

    

    
    var view: CreateTeamPresenterToViewProtocol?
    
    var interactor: CreateTeamPresenterToInteractorProtocol?
    
    var router: CreateTeamPresenterToRouterProtocol?
    
    func createNewTeam(teamInformation: TeamInfo) {
        interactor?.createNewTeam(teamInformation: teamInformation)
    }
    
    func editTeam(teamInformation: TeamInfo, viewController: UIViewController) {
        interactor?.editTeam(teamInformation: teamInformation)
    }
    
    func selectPokemons(navigationController: UINavigationController,regionName:String?) {
        router?.askForPokemons(viewController: navigationController, regionName: regionName, listener: self)
    }
    
    func dismissViewController(navigationController: UINavigationController) {
        router?.dismissViewController(viewController: navigationController)
    }
    
}

extension CreateTeamPresenter:CreateTeamInteractorToPresenter{
    func didFinishCreatingTeam() {
        view?.didFinishCreatingTeam()
    }
    
    func didFinishEditingTeam() {
        
    }
    
    func didFinishWithError(error:Error) {
        view?.showError(error: error)
    }
    
    
}

extension CreateTeamPresenter:ChooseRegionAndPokemonProtocol{
    func didSelectPokemonAndRegion(region: String?, pokemons: [TeamPokemon]?) {

        if pokemons != nil{
            view?.didSelectPokemonForTeam(pokemon: pokemons ?? [])

        }
        
        if region != nil{
            view?.didSelectRegion(regionName: region ?? "")
        }
    }
    
    
}
