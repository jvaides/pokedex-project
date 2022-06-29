//
//  PokemonProtocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

protocol PokemonViewToPresenterProtocol:AnyObject {
    /**
     This  is a property variable to make a reference to PokemonPresenterToViewProtocol
     */
    var view:PokemonPresenterToViewProtocol? {get set}

    /**
     This  is a property variable to make a reference to PokemonPresenterToInteractorProtocol
     */
    var interactor:PokemonPresenterToInteractorProtocol? {get set}

    /**
     This  is a property variable to make a reference to PokemonPresenterToRouterProtocol
     */
    var router:PokemonPresenterToRouterProtocol? {get set}

    /**
     This  is a property variable to make a reference to FavoritedPokemonProtocol
     */
    var favoritedPokemonProtocol:FavoritedPokemonProtocol? {get set}

    /**
     Use this method to get the image for the pokemon
     - parameter orderNumber: The stored id of the pokemon
     */
    func getPokemonImage(orderNumber:Int)

    /**
     Use this method to add a pokemon to the team
     - parameter pokemon: The Firebase auth credential received from API
     - parameter navigationController: The referenced navigation controller to segue back to main view

     */
    func addPokemonToTeam(pokemon:TeamPokemon,
                          navigationController:UINavigationController)
}

protocol PokemonPresenterToViewProtocol:AnyObject {
    /**
     Use this method to display on the view  the image for the pokemon
     - parameter imageData: The image data
     - parameter url: The url where the image is hosted

     */
    func displayPokemonImage(imageData:Data,
                             imageUrl:String)

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func showError(error:Error)
}

protocol PokemonPresenterToRouterProtocol:AnyObject{

    /**
     Use this method to create a new instance of a viewcontroller of type TeamsViewController
     */
    static func createPokemonModule(_ listener:PokemonsListPresenter?) -> PokemonViewController

    /**
     Use this method to inform that a pokemon was selected for the team
     - parameter navigationController: The referenced navigation controller to segue back to main view

     */
    func didSelectPokemonForTeam(navigationController:UINavigationController)
}

protocol PokemonPresenterToInteractorProtocol:AnyObject{
    var presenter:PokemonInteractorToPresenterProtocol? {get set}

    /**
     Use this method to get the image for the pokemon
     - parameter orderNumber: The stored id of the pokemon
     */
    func getPokemonImage(orderNumber:Int)
}

protocol PokemonInteractorToPresenterProtocol:AnyObject{
    /**
     Use this method to display on the view  the image for the pokemon
     - parameter imageData: The image data
     - parameter url: The url where the image is hosted

     */
    func didFinishLoadingImage(imageData:Data,
                               imageUrl:String)

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func didFinishWithError(error:Error)
}
