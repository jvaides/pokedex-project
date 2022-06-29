//
//  CreateTeamInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
class CreateTeamInteractor:CreateTeamPresenterToInteractorProtocol{

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var presenter: CreateTeamInteractorToPresenter?
    
    func createNewTeam(teamInformation: TeamInfo) {
        do{
            guard let autoId = appDelegate.database_ref?.child(FIR_REF_TEAMS).child((appDelegate.auth?.currentUser!.uid)!).childByAutoId().key else {
                        return
                    }
            let teamDic = try teamInformation.asDictionary()
            appDelegate.database_ref?
                .child(FIR_REF_TEAMS)
                .child((appDelegate.auth?.currentUser!.uid)!)
                .child(autoId)
                .setValue(["user":appDelegate.auth?.currentUser!.displayName!,
                           "region":teamInformation.region!,
                           "pokemons":teamDic["pokemons"],
                           "name":teamInformation.name!])
            presenter?.didFinishCreatingTeam()
                
        }catch let error{
            presenter?.didFinishWithError(error: error)
        }

    }
    
    func editTeam(teamInformation: TeamInfo) {
        do{
            
            let teamDic = try teamInformation.asDictionary()
            appDelegate.database_ref?
                .child(FIR_REF_TEAMS)
                .child((appDelegate.auth?.currentUser!.uid)!)
                .child(teamInformation.team_id!)
                .setValue(["user":appDelegate.auth?.currentUser!.displayName!,
                           "region":teamInformation.region!,
                           "pokemons":teamDic["pokemons"],
                           "name":teamInformation.name!])
            presenter?.didFinishCreatingTeam()
                
        }catch let error{
            presenter?.didFinishWithError(error: error)
        }
    }
    
    
}
