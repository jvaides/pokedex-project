//
//  CreateTeamProtocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
protocol CreateTeamViewToPresenterProtocol:AnyObject {
    /**
     This  is a property variable to make a reference to CreateTeamPresenterToViewProtocol
     */
    var view:CreateTeamPresenterToViewProtocol? {get set}

    /**
     This  is a property variable to make a reference to CreateTeamPresenterToInteractorProtocol
     */
    var interactor:CreateTeamPresenterToInteractorProtocol? {get set}

    /**
     This  is a property variable to make a reference to CreateTeamPresenterToRouterProtocol
     */
    var router:CreateTeamPresenterToRouterProtocol? {get set}
    
    /**
     Use this method to create a new team
     - parameter teamInformation: The information object used to save data on firebase
     */
    func createNewTeam(teamInformation:TeamInfo)

    /**
     Use this method to edit a team
     - parameter teamInformation: The information object used to save data on firebase
     - parameter viewController: A reference to the view controller from where we ase presenting a new view controller
     */
    func editTeam(teamInformation:TeamInfo,
                  viewController:UIViewController)

    /**
     Use this method to move to a vc where the region pokedex will be displayed
     - parameter navigationController: A reference to the view controller from where we ase presenting a new view controller API
     - parameter regionName: A name of a selected pokemon region
     */
    func selectPokemons(navigationController:UINavigationController,
                        regionName:String?)


    func dismissViewController(navigationController:UINavigationController)
}

protocol CreateTeamPresenterToViewProtocol:AnyObject {
    /**
     Use this method to inform that a region has been selected
     - parameter regionName: Name of the pokemon region
     */
    func didSelectRegion(regionName:String)

    /**
     Use this method to inform that a list of pokemons has been selected to use for the team
     - parameter pokemon: Array containing the pokemos for the team
     */
    func didSelectPokemonForTeam(pokemon:[TeamPokemon])

    /**
     Use this method to inform that creating a team completed successfully
     */
    func didFinishCreatingTeam()

    /**
     Use this method to inform that we have fnished editing the team
     */
    func didFinishEditingTeam()

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func showError(error:Error)
}

protocol CreateTeamPresenterToInteractorProtocol:AnyObject {
    /**
     This  is a property variable to make a reference to CreateTeamInteractorToPresenter
     */
    var presenter:CreateTeamInteractorToPresenter?{get set}

    /**
     Use this method to create a new team
     - parameter teamInformation: The information object used to save data on firebase
     */
    func createNewTeam(teamInformation:TeamInfo)

    /**
     Use this method to edit a team
     - parameter teamInformation: The information object used to save data on firebase
     */
    func editTeam(teamInformation:TeamInfo)
}


protocol CreateTeamPresenterToRouterProtocol:AnyObject{
    static func createCreateTeamModule() -> CreateTeamViewController
    /**
     Use this method to move to another VC to list all pokemons
     - parameter viewController: The refence view from where a new vc will be presented
     - parameter regionName: A name of a selected pokemon region
     - parameter listener: A reference to CreateTeamPresenter to pass data between controllers
     */
    func askForPokemons(viewController:UINavigationController,
                        regionName:String?,
                        listener:CreateTeamPresenter?)


    func dismissViewController(viewController:UINavigationController)
}

protocol CreateTeamInteractorToPresenter:AnyObject {
    /**
     Use this method to inform that we finish creating a team
     */
    func didFinishCreatingTeam()

    /**
     Use this method to inform that we finish editing a team
     */
    func didFinishEditingTeam()

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func didFinishWithError(error:Error)
}

//MARK: DelegationProtocols
protocol ChooseRegionAndPokemonProtocol:AnyObject{
    /**
     Use this method to pass the received information
     - parameter region:  A name of a selected pokemon region
     - parameter pokemons: Array containing the pokemos for the team

     */
    func didSelectPokemonAndRegion(region:String?,pokemons:[TeamPokemon]?)
}
