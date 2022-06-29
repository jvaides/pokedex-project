//
//  TeamsViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import UIKit

class TeamsViewController: UIViewController {

    var presentor:TeamsViewToPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    fileprivate var teams:[TeamInfo]?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Equipos"
        setUpTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showProgressIndicator(view: self.view)
        presentor?.getUserTeams()

    }
    
    func setUpTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let teamnib = UINib(nibName: TeamsTableViewCell.identifier, bundle: nil)
        self.tableView.register(teamnib, forCellReuseIdentifier: TeamsTableViewCell.identifier)
    }
    
    @IBAction func createTeamButton(_ sender: Any) {
        showProgressIndicator(view: self.view)
        presentor?.createNewTeam(viewController: self)
    }
    

}

extension TeamsViewController:TeamsPresenterToViewProtocol{
    func displayPokeImage(image: Data, poke_id: Int,atCell:IndexPath) {
        DispatchQueue.main.async {
            let visibleCellsAtDsiplay = self.tableView.indexPathsForVisibleRows
            if ((visibleCellsAtDsiplay?.contains(where: {$0 == atCell})) != nil){
                if let cell = self.tableView.cellForRow(at: atCell) as? TeamsTableViewCell{
                    switch poke_id {
                    case 0:
                        cell.setPokeImage1(data: image)
                    case 1:
                        cell.setPokeImage2(data: image)
                    case 2:
                        cell.setPokeImage3(data: image)
                    case 3:
                        cell.setPokeImage4(data: image)
                    case 4:
                        cell.setPokeImage5(data: image)
                    case 5:
                        cell.setPokeImage6(data: image)
                    default:
                        cell.setPokeImage1(data: image)
                    }
                }
            }
        }
        
        
    }
    
    func informDeleteCompletion() {
        hideProgressIndicator(view: self.view)
    }
    
    func displayTeamsList(teams: [TeamInfo]) {
        hideProgressIndicator(view: self.view)
        if teams.isEmpty{
            self.tableView.isHidden = true
        }else{
            self.teams = teams
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func showError(error:Error) {
        
    }
    
    
}

extension TeamsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.identifier, for: indexPath) as! TeamsTableViewCell
        let team = self.teams?[indexPath.row]
        cell.teamName.text = "Equipo \(team?.name ?? "")"
        cell.regionName.text = team?.region ?? ""
        cell.regionTitle.text = "Región"
        cell.createdBy.text = "Creado Por: \(team?.user ?? "")"
        cell.pokeImage1.image = nil
        cell.pokeImage2.image = nil
        cell.pokeImage3.image = nil
        cell.pokeImage4.image = nil
        cell.pokeImage5.image = nil
        cell.pokeImage6.image = nil
        for (i,pokemon) in (team?.pokemons ?? []).enumerated() {
            presentor?.getPokemonImage(url: pokemon.pokemon_image ?? "", poke_id: i, atCell: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let teamCell = cell as? TeamsTableViewCell
        teamCell?.layoutSubviews()
        teamCell?.layoutIfNeeded()
        teamCell?.containerView.dropShadow(color: .lightGray, offSet: CGSize(width:0, height: 2))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = (self.teams?[indexPath.row])!
        presentor?.editTeam(teamInformation: team, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                // delete the item here
                tableView.beginUpdates()
                let team = self.teams?[indexPath.row]
                self.teams?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                self.presentor?.deleteTeam(team_id: (team?.team_id!)!)
                //self.changesWereMadeToData = true
                //self.saveTeam.isHidden = false
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
}
