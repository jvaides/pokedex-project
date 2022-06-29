//
//  PokemonsListProtocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

protocol PokemonsListViewToPresenterProtocol:AnyObject{
    /**
     This  is a property variable to make a reference to PresenterToViewProtocol
     */
    var view:PokemonsListPresenterToViewProtocol? {get set}

    /**
     This  is a property variable to make a reference to PresenterToViewProtocol
     */
    var interactor:PokemonsListPresenterToInteractorProtocol? {get set}

    /**
     This  is a property variable to make a reference to PresenterToViewProtocol
     */
    var router:PokemonsListPresenterToRouterProtocol? {get set}

    /**
     This  is a property variable to make a reference to PresenterToViewProtocol
     */
    var selectedPokemonsProtocol:ChoosePokemonsProtocol? {get set}

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func getRegionPokedex(region:RequestResult)

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func showPokemonInformation(pokemon:PokemonInformation,
                                navigationController:UINavigationController)

}

protocol PokemonsListPresenterToViewProtocol:AnyObject{
    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func displayRegionPokedex(processedPokedex:[PokemonInformation])

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func showError(error:Error)
}

protocol PokemonsListPresenterToRouterProtocol:AnyObject{
    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    static func createPokemonListModule(_ listener:HomePresenter?) -> PokemonsListViewController

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func segueToPokemonInformation(pokemon:PokemonInformation,
                                   navigationController:UINavigationController,
                                   _ listener:PokemonsListPresenter?)
}

protocol PokemonsListPresenterToInteractorProtocol:AnyObject{
    var presenter:PokemonsListInteractorToPresenterProtocol?{get set}

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func getRegionPokedex(region:RequestResult)
}

protocol PokemonsListInteractorToPresenterProtocol:AnyObject{

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func didFinishCreatingPokedex(processedPokedex:[PokemonInformation])

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func didFinishWithError(error:Error)
}

//MARK: DelegationProtocols
protocol FavoritedPokemonProtocol:AnyObject{
    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func didSelectPokemon(pokemon:TeamPokemon)
}
