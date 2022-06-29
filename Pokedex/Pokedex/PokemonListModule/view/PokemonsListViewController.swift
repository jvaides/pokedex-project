//
//  PokemonsListViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit
class PokemonsListViewController:UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var presentor:PokemonsListViewToPresenterProtocol?
    var region:RequestResult?
    fileprivate var pokemons:[PokemonInformation]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        self.title = "\(region?.name ?? "Not found") Pokédex"
        showProgressIndicator(view: self.view)
        presentor?.getRegionPokedex(region: region!)
    }
    
    fileprivate func setUpTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension PokemonsListViewController:PokemonsListPresenterToViewProtocol{
    func displayRegionPokedex(processedPokedex: [PokemonInformation]) {
        hideProgressIndicator(view: self.view)
        self.pokemons = processedPokedex.sorted(by: {$0.order ?? 0 < $1.order ?? 0})
        self.tableView.reloadData()
    }
    
    func showError(error:Error) {
        hideProgressIndicator(view: self.view)
        showAlertMessage(message: error.localizedDescription, viewController: self)
    }
    
    
}

extension PokemonsListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentLangCode = Locale.current.languageCode
        let pokemon = pokemons?[indexPath.row]
        cell.selectionStyle = .none
        if let translatedPokemonName = pokemon?.names?.first(where: {$0.language.name == currentLangCode}){
            cell.textLabel?.text = "No.\(pokemon?.order ?? 0) \(translatedPokemonName.name)"

        }else{
            cell.textLabel?.text = "Not found"

        }
        if let translatedPokemonName = pokemon?.genera?.first(where: {$0.language.name == currentLangCode}){
            cell.detailTextLabel?.text = translatedPokemonName.genus

        }else{
            cell.detailTextLabel?.text = "Not found"

        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons?[indexPath.row]
        presentor?.showPokemonInformation(pokemon: pokemon!, navigationController: navigationController!)
    }
    
}
