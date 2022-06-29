//
//  TeamsInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
import FirebaseDatabase

class TeamsInteractor:TeamsPresenterToInteractorProtocol{

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var presenter: TeamsInteractorToPresenterProtocol?
    
    func getUserTeams() {
        let user_id = appDelegate.auth?.currentUser?.uid
        appDelegate.database_ref?.child(FIR_REF_TEAMS).child(user_id!).observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.hasChildren(){
                do{
                    let documents = snapshot.children
                    var teams:[TeamInfo] = []
                    for child in documents {
                        let autoIdSnap = child as! DataSnapshot //each listing
                        let childDict = autoIdSnap.value as! NSDictionary
                        let data = try JSONSerialization.data(withJSONObject: childDict, options: .fragmentsAllowed)
                        var team = try JSONDecoder().decode(TeamInfo.self, from: data)
                        team.team_id = autoIdSnap.key
                        teams.append(team)
                    }
                   
                    self.presenter?.didFinishLoadingTeams(teams: teams)

                }catch let error{
                    self.presenter?.didFinishWithError(error: error)
                }
            }else{
                let emptyTeams:[TeamInfo] = []
                self.presenter?.didFinishLoadingTeams(teams: emptyTeams)
            }

            //let data = try JSONSerialization.data(withJSONObject: documents, options: .fragmentsAllowed)
           // let myListings = try JSONDecoder().decode([Listing].self, from: data)
        })
        //appDelegate.database_ref?.child(FIR_REF_TEAMS).queryEqual(toValue: appDelegate.auth?.currentUser?.uid, childKey: FIR_REF_USER_OWNER).
    }
    
    func deleteTeam(team_id: String, viewController: UIViewController) {
        let user_id = appDelegate.auth?.currentUser?.uid
        appDelegate.database_ref?.child(FIR_REF_TEAMS).child(user_id!).child(team_id).removeValue()
    }
    
    
    func getPokemonImage(imageUrl: String,poke_id:Int,atCell:IndexPath) {
        NetworkService.GetPokemonImage(url: imageUrl) { file, error in
            if error == nil{
                self.presenter?.didFinishLoadingImage(data: file as! Data, poke_id: poke_id,atCell: atCell)
            }else{
                let image = UIImage(named: "notfound")
                self.presenter?.didFinishLoadingImage(data: (image?.pngData())!, poke_id: poke_id, atCell: atCell)
            }
        }
    }
    
    
}
