//
//  TeamsPresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
class TeamsPresenter:TeamsViewToPresenterProtocol{

    
    var view: TeamsPresenterToViewProtocol?
    
    var interactor: TeamsPresenterToInteractorProtocol?
    
    var router: TeamsPresenterToRouterProtocol?
    
    func getUserTeams() {
        interactor?.getUserTeams()
    }
    
    func createNewTeam(viewController: UIViewController) {
        router?.segueToCreateNewTeam(viewControllerL: viewController)
    }
    
    func editTeam(teamInformation: TeamInfo, viewController: UIViewController) {
        router?.segueToEditTeam(viewController: viewController,teamInformation: teamInformation)
    }
    
    func deleteTeam(team_id: String) {
        interactor?.deleteTeam(team_id: team_id, viewController: UIViewController())
    }
    
    func getPokemonImage(url: String,poke_id:Int,atCell:IndexPath) {
        interactor?.getPokemonImage(imageUrl: url,poke_id: poke_id,atCell: atCell)
    }
    
    
}

extension TeamsPresenter:TeamsInteractorToPresenterProtocol{
    func didFinishLoadingImage(data: Data, poke_id: Int,atCell:IndexPath) {
        view?.displayPokeImage(image: data, poke_id: poke_id,atCell: atCell)
    }
    
    func didFinishLoadingTeams(teams: [TeamInfo]) {
        view?.displayTeamsList(teams: teams)
    }
    
    func didFinishDeletingTeam() {
        
    }
    
    func didFinishWithError(error:Error) {
        
    }
    
    
}
