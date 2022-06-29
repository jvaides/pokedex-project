//
//  HomeViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import Foundation
import UIKit

class HomeViewController:UIViewController{
    @IBOutlet weak var tableView: UITableView!

    var presentor:HomeViewToPresenterProtocol?
    var regions:PokemonModel?
    var alreadySelectedRegion:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Regiones"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setUpTable()
        self.getPokemonLeagues()
    }
    

    fileprivate func setUpTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    fileprivate func getPokemonLeagues(){
        showProgressIndicator(view: self.view)
        presentor?.requestPokemonLeagues()
    }
}
extension HomeViewController:HomePresenterToViewProtocol{
    func displayPokemonLeagues(leagues: PokemonModel) {
        hideProgressIndicator(view: self.view)
        self.regions = leagues
        self.tableView.reloadData()
        if alreadySelectedRegion != nil{
            presentor?.selectedRegion(regionName: alreadySelectedRegion!)
            presentor?.showLeagueDetail(leagueInfo: (regions?.results?.first(where: {$0.name == self.alreadySelectedRegion}))!, navigationConroller: navigationController!)
        }
    }
    
    func showError(error:Error) {
        hideProgressIndicator(view: self.view)
        showAlertMessage(message: error.localizedDescription, viewController: self)
    }
    
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions?.count ?? 0

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = regions?.results?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRegion = regions?.results?[indexPath.row]
        if alreadySelectedRegion != nil{
            if alreadySelectedRegion == selectedRegion?.name ?? ""{
                self.presentor?.showLeagueDetail(leagueInfo: selectedRegion!, navigationConroller: navigationController!)
                self.presentor?.selectedRegion(regionName: selectedRegion?.name ?? "Error")
            }else{
                showAlertMessage(message: "No se puede cambiar de region, una vez un pokemon de una region se haya seleccionado antes", viewController: self)
            }

        }else{
            self.presentor?.showLeagueDetail(leagueInfo: selectedRegion!, navigationConroller: navigationController!)
            self.presentor?.selectedRegion(regionName: selectedRegion?.name ?? "Error")
        }

    }
    
    
}
