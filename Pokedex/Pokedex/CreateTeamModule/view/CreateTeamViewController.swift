//
//  CreateTeamViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import UIKit

class CreateTeamViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var teamNameField: UITextField!
    
    @IBOutlet weak var saveTeam: UIButton!
    
    @IBOutlet weak var regionLabel: UILabel!
    
    var presentor:CreateTeamViewToPresenterProtocol?
    
    var region:String?
    
    var pokemonsForTeam:[TeamPokemon]?
    
    var teamInfo: TeamInfo?
    
    var isEditingView:Bool?
    
    var changesWereMadeToData:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        if isEditingView ?? false{
            self.title = "Equipo"
            self.teamNameField.text = teamInfo?.name
            self.regionLabel.text = "Región Pokémon  \(self.region ?? "")"
            self.pokemonsForTeam = teamInfo?.pokemons
            tableView.reloadData()
           

        }else{
            self.title = "Nuevo Equipo"

        }
        self.saveTeam.isHidden = true
    }
    

    fileprivate func setUpTable(){
        self.tableView.dataSource = self
        self.tableView.delegate =  self
    }
    
    @IBAction func addPokemonButton(_ sender: Any) {
        if (pokemonsForTeam?.count ?? 0) <= 6{
            presentor?.selectPokemons(navigationController: navigationController!,regionName: region)
        }else{
            //showWarning
            showAlertMessage(message: "El equipo debe de tener como maximo 6 pokemons", viewController: self)
        }
        
    }
    
    @IBAction func saveTeamInformation(_ sender: Any) {
        //
        if (pokemonsForTeam?.count ?? 0) >= 3 && (pokemonsForTeam?.count ?? 0) <= 6{
            showProgressIndicator(view: self.view)
            if isEditingView ?? false{
                teamInfo?.pokemons = pokemonsForTeam
                teamInfo?.name = teamNameField.text
                presentor?.editTeam(teamInformation: teamInfo!, viewController: self)
            }else{
                teamInfo = TeamInfo(team_id: nil, team_user_access: nil, pokemons: self.pokemonsForTeam, region: self.region,name: teamNameField.text!)
                presentor?.createNewTeam(teamInformation: teamInfo ?? TeamInfo())
            }
        }else if (pokemonsForTeam?.count ?? 0) <= 2{
            showAlertMessage(message: "El equipo debe de tener como minimo 3 pokemons", viewController: self)
        }else if (pokemonsForTeam?.count ?? 0) >= 5{
            showAlertMessage(message: "El equipo debe de tener como maximo 6 pokemons", viewController: self)
        }else{
            showAlertMessage(message: "El equipo debe de tener como minimo 3 pokemons y maximo 6 pokemons", viewController: self)
        }
        
        
    }
    
    @IBAction func cancelCreation(_ sender: Any) {
        presentor?.dismissViewController(navigationController: navigationController!)
    }
    
}

extension CreateTeamViewController:CreateTeamPresenterToViewProtocol{
    func didSelectRegion(regionName: String) {
        self.region = regionName
        self.regionLabel.text = "Pokemon Region \(self.region ?? "")"
        self.saveTeam.isHidden = false
    }
    
    func didSelectPokemonForTeam(pokemon: [TeamPokemon]) {
        if pokemonsForTeam == nil{
            pokemonsForTeam = pokemon
        }else{
                pokemonsForTeam! += pokemon
        }
        self.tableView.reloadData()
        if isEditingView ?? false{
            self.changesWereMadeToData = true
        }
        self.saveTeam.isHidden = false
    }
    
    func didFinishCreatingTeam() {
        hideProgressIndicator(view: self.view)
        presentor?.dismissViewController(navigationController: navigationController!)
    }
    
    func didFinishEditingTeam() {
        hideProgressIndicator(view: self.view)
    }
    
    func showError(error:Error) {
        hideProgressIndicator(view: self.view)
        showAlertMessage(message: error.localizedDescription, viewController: self)
    }
    
    
}

extension CreateTeamViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsForTeam?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let pokemon = pokemonsForTeam?[indexPath.row]
        cell.textLabel?.text = pokemon?.name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                // delete the item here
                tableView.beginUpdates()
                self.pokemonsForTeam?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                self.changesWereMadeToData = true
                self.saveTeam.isHidden = false
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }

    
    
}
