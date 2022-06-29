//
//  HomeProtocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

protocol HomeViewToPresenterProtocol:AnyObject{
    /**
     This  is a property variable to make a reference to conform to HomePresenterToViewProtocol
     */
    var view:HomePresenterToViewProtocol? {get set}

    /**
     This  is a property variable to make a reference to HomePresenterToInteractorProtrocol
     */
    var interactor:HomePresenterToInteractorProtrocol? {get set}

    /**
     This  is a property variable to make a reference to HomePresenterToRouterProtocol
     */
    var router:HomePresenterToRouterProtocol? {get set}

    /**
     This  is a property variable to make a reference to ChooseRegionAndPokemonProtocol
     */
    var chosenRegionAndPokemons:ChooseRegionAndPokemonProtocol?{get set}

    /**
     This method  asks the interactor to get the different pokemon regions
     */
    func requestPokemonLeagues()

    /**
     Use this method to display  the pokedex
     - parameter leagueInfo: The result Region object containing information
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func showLeagueDetail(leagueInfo:RequestResult,
                          navigationConroller:UINavigationController)


    func selectedRegion(regionName:String)
}

protocol HomePresenterToViewProtocol:AnyObject{
    /**
     Use this method to inform the view to display the list of regions
     - parameter leagues: The result Regions object containing information
     */
    func displayPokemonLeagues(leagues:PokemonModel)

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func showError(error:Error)
}

protocol HomePresenterToRouterProtocol:AnyObject{
    /**
     Use this method to create an instance of a view controller of type HomeViewController
     - parameter listener: A reference of CreateTeamPresenter to pass data back from this module
     */
    static func createHomeModule(_ listener:CreateTeamPresenter?) -> HomeViewController

    /**
     Use this method to display  the pokedex
     - parameter leagueInfo: The result Region object containing information
     - parameter navigationController:The navigation controller from where the next view will be presented
     - parameter listener:A reference to this module presenter to pass data between controllers
     */

    func segueToLeagueDetail(leagueInfo:RequestResult,
                             navigationConroller:UINavigationController,
                             _ listener:HomePresenter?)
}

protocol HomePresenterToInteractorProtrocol:AnyObject{
    /**
     This  is a property variable to make a reference to HomeInteractorToPresenterProtocol
     */
    var presenter:HomeInteractorToPresenterProtocol? {get set}

    /**
     This method  asks the interactor to  get the pokemon regions

     */
    func getPokemonLeagues()
}

protocol HomeInteractorToPresenterProtocol:AnyObject{
    /**
     Use this method to inform the presenter to display the list of regions
     - parameter leagues: The result Regions object containing information
     */
    func noticeReceivedLeagues(leagues:PokemonModel)

    /**
     Use this method to inform the presenter to display the errors
     - parameter error: Errors resulted from API calls
     */
    func errorReceivedFromApi(error:Error)
}

//MARK: DelegationProtocols
protocol ChoosePokemonsProtocol:AnyObject{
    /**
     Use this method to receive data from pokemons list
     - parameter region: The profile information receved from user login
     - parameter pokemons:The navigation controller from where the next view will be presented
     */
    func didSelectPokemons(region:String?,pokemons:[TeamPokemon]?)
}
