//
//  TeamsProtocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
protocol TeamsViewToPresenterProtocol:AnyObject{
    /**
     This  is a property variable to make a reference to conform to TeamsPresenterToViewProtocol
     */
    var view:TeamsPresenterToViewProtocol? {get set}

    /**
     This  is a property variable to make a reference to conform to TeamsPresenterToInteractorProtocol
     */
    var interactor:TeamsPresenterToInteractorProtocol? {get set}

    /**
     This  is a property variable to make a reference to conform to TeamsPresenterToRouterProtocol
     */
    var router:TeamsPresenterToRouterProtocol? {get set}


    /**
     Use this method to fetch the user teams from the firebase database
     */
    func getUserTeams()

    /**
     Use this method to present a new view controller for creeating a team
     - parameter viewController: A reference to a view controller from where we will present a new vc
     */
    func createNewTeam(viewController:UIViewController)

    /**
     Use this method to edit an exisiting team
     - parameter teamInformation: The information of the team we will edit
     - parameter viewController: A reference to a view controller from where we will present a new vc

     */
    func editTeam(teamInformation:TeamInfo,
                  viewController:UIViewController)

    /**
    Use this method to delete an existing team
     - parameter team_id: The id of the firebase object to delete
     */
    func deleteTeam(team_id:String)

    /**
     Use this method to get the image for the pokemon
     - parameter url: The  stored url for the pokemon
     - parameter poke_id: The stored id of the pokemon
     - parameter atCell: The cell index path from where this method is being called

     */
    func getPokemonImage(url:String,
                         poke_id:Int,
                         atCell:IndexPath)
}

protocol TeamsPresenterToViewProtocol:AnyObject{
    /**
     Use this method to display the list of teams created by the user
     - parameter teams: The list of teams
     */
    func displayTeamsList(teams:[TeamInfo])

    /**
     Use this method to inform the view that a deletion was completed
     */
    func informDeleteCompletion()

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func showError(error:Error)

    /**
     Use this method to display on the view  the image for the pokemon
     - parameter url: The  stored url for the pokemon
     - parameter poke_id: The stored id of the pokemon
     - parameter atCell: The cell index path from where this method is being called

     */
    func displayPokeImage(image:Data,
                          poke_id:Int,
                          atCell:IndexPath)
}

protocol TeamsPresenterToRouterProtocol:AnyObject{
    /**
     Use this method to create a new instance of a viewcontroller of type TeamsViewController
     */
    static func createTeamsModule() -> TeamsViewController

    /**
     Use this method to move to the create team vc
     - parameter viewControllerL: The view controller from where the next view will be presented
     */
    func segueToCreateNewTeam(viewControllerL:UIViewController)

    /**
     Use this method to move to the edit  team vc
     - parameter viewController: The view controller from where the next view will be presented
     - parameter teamInformation: The team that we will edit

     */
    func segueToEditTeam(viewController:UIViewController,
                         teamInformation:TeamInfo)
    
}

protocol TeamsPresenterToInteractorProtocol:AnyObject{
    var presenter:TeamsInteractorToPresenterProtocol?{get set}

    /**
     Use this method to fetch the user teams from the firebase database
     */
    func getUserTeams()

    /**
    Use this method to delete an existing team
     - parameter team_id: The id of the firebase object to delete
     */
    func deleteTeam(team_id:String,viewController:UIViewController)

    /**
     Use this method to get the image for the pokemon
     - parameter imageUrl: The  stored url for the pokemon
     - parameter poke_id: The stored id of the pokemon
     - parameter atCell: The cell index path from where this method is being called

     */
    func getPokemonImage(imageUrl:String,poke_id:Int,atCell:IndexPath)
}


protocol TeamsInteractorToPresenterProtocol:AnyObject{
    /**
     Use this method to display the list of teams created by the user
     - parameter teams: The list of teams
     */
    func didFinishLoadingTeams(teams:[TeamInfo])
    
    /**
     Use this method to inform the view that a deletion was completed
     */
    func didFinishDeletingTeam()

    /**
     Use this method to inform the view that there was an error
     - parameter error: Error result from API call
     */
    func didFinishWithError(error:Error)

    /**
     Use this method to display on the view  the image for the pokemon
     - parameter data: The image data
     - parameter poke_id: The stored id of the pokemon
     - parameter atCell: The cell index path from where this method is being called

     */
    func didFinishLoadingImage(data:Data,poke_id:Int,atCell:IndexPath)
}

