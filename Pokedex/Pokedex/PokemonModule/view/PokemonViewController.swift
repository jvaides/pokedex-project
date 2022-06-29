//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit
class PokemonViewController:UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    var presentor:PokemonViewToPresenterProtocol?
    var pokemon:PokemonInformation?
    var pokemonForTeam:TeamPokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        self.title = "Información"
        pokemonForTeam = TeamPokemon()
        showProgressIndicator(view: self.view)
        presentor?.getPokemonImage(orderNumber: pokemon?.order ?? 0)
    }
    
    func setUpTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let generalNib = UINib(nibName: PokemonDefaultTableViewCell.identifier, bundle: nil)
        let imageNib = UINib(nibName: PokemonImageTableViewCell.identifier, bundle: nil)
        self.tableView.register(generalNib, forCellReuseIdentifier: PokemonDefaultTableViewCell.identifier)
        self.tableView.register(imageNib, forCellReuseIdentifier: PokemonImageTableViewCell.identifier)
    }
    
    @IBAction func addToTeamButton(_ sender: Any) {
        self.pokemonForTeam?.order = pokemon?.order ?? 0
        self.pokemonForTeam?.pokemon_url = POKEMON_API_V2+POKEMON_GENERAL_INFO+"\(pokemon?.order ?? 0)"
        self.pokemonForTeam?.species_url = POKEMON_API_V2+POKEMON_SPECIES_INFO+"\(pokemon?.order ?? 0)"
        presentor?.addPokemonToTeam(pokemon: self.pokemonForTeam ?? TeamPokemon(), navigationController: navigationController!)
    }
    
}

extension PokemonViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0{
            let imagecell = tableView.dequeueReusableCell(withIdentifier: PokemonImageTableViewCell.identifier, for: indexPath) as! PokemonImageTableViewCell
            return imagecell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonDefaultTableViewCell.identifier, for: indexPath) as! PokemonDefaultTableViewCell
            let currentLangCode = Locale.current.languageCode

            switch indexPath.row {
            case 1:
                cell.pokemonTitleInfo.text = "Nombre"
                if let translatedPokemonName = pokemon?.names?.first(where: {$0.language.name == currentLangCode}){
                    cell.pokemonDescription.text = " \(translatedPokemonName.name)"
                    self.pokemonForTeam?.name = translatedPokemonName.name
                }else{
                    cell.pokemonDescription.text = "Not found"

                }
                
            case 2:
                cell.pokemonTitleInfo.text = "Descripción de pokédex"
                if let translatedPokemonName = pokemon?.flavor_text_entries?.first(where: {$0.language?.name == currentLangCode}){
                    cell.pokemonDescription.text = translatedPokemonName.flavor_text

                }else{
                    cell.pokemonDescription.text = "Not found"

                }
            case 3:
                cell.pokemonTitleInfo.text = "Número en pokédex"
                cell.pokemonDescription.text = "\(pokemon?.order ?? 0)"
                
            case 4:
                
                cell.pokemonTitleInfo.text = "Típo"
                if let translatedPokemonName = pokemon?.genera?.first(where: {$0.language.name == currentLangCode}){
                    cell.pokemonDescription.text = translatedPokemonName.genus

                }else{
                    cell.pokemonDescription.text = "Not found"

                }
                
            default:
                return UITableViewCell()
            }
            return cell
        }
    }
    
    
}

extension PokemonViewController:PokemonPresenterToViewProtocol{
    func displayPokemonImage(imageData: Data,imageUrl:String) {
        DispatchQueue.main.async {
            hideProgressIndicator(view: self.view)
            self.pokemonForTeam?.pokemon_image = imageUrl
            let indexPath = IndexPath(row: 0, section: 0)
            DispatchQueue.main.async {
                if let imageCell = self.tableView.cellForRow(at: indexPath) as? PokemonImageTableViewCell{
                    imageCell.pokemonImage.image =  UIImage(data: imageData)
                }
            }
        }


    }
    
    func showError(error:Error) {
        hideProgressIndicator(view: self.view)
        showAlertMessage(message: error.localizedDescription, viewController: self)
    }
    
    
}
