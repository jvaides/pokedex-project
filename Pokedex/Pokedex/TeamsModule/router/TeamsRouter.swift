//
//  TeamsRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 27/06/22.
//

import Foundation
import UIKit
class TeamsRouter:TeamsPresenterToRouterProtocol{
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    static func createTeamsModule() -> TeamsViewController {
        let view = storyBoard.instantiateViewController(identifier: "TeamsViewController") as! TeamsViewController
        let presenter: TeamsViewToPresenterProtocol & TeamsInteractorToPresenterProtocol = TeamsPresenter()
        let interactor: TeamsPresenterToInteractorProtocol = TeamsInteractor()
        let router:TeamsPresenterToRouterProtocol = TeamsRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    func segueToCreateNewTeam(viewControllerL: UIViewController) {
        let vc = CreateTeamRouter.createCreateTeamModule()
        let navigationController = UINavigationController()
        navigationController.setViewControllers([vc], animated: true)
        navigationController.modalPresentationStyle = .fullScreen
        viewControllerL.present(navigationController, animated: true)
    }
    
    func segueToEditTeam(viewController: UIViewController,teamInformation:TeamInfo) {
        let createTeam = CreateTeamRouter.createCreateTeamModule()
        createTeam.teamInfo = teamInformation
        createTeam.region = teamInformation.region
        createTeam.isEditingView = true
        let navigationController = UINavigationController()
        navigationController.setViewControllers([createTeam], animated: true)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true)
    }
    
    
}
