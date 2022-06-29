//
//  LogInRouter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation
import FirebaseAuth

// MARK: PresenterToRouterProtocol
class LogInRouter:PresenterToRouterProtocol{
    /**
     Variable with a reference to Main Storyboard
     */
    static var storyBoard:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: .main)
    }
    
    func segueToHome(userInfo: LogInModel,navigationConroller:ViewController) {
        
        if let homeVc = LogInRouter.storyBoard.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController{
            let regionsHome = HomeRouter.createHomeModule(nil)
            let teamsHome = TeamsRouter.createTeamsModule()
            
            let newNavigationController = UINavigationController()
            newNavigationController.viewControllers = [regionsHome]
            newNavigationController.tabBarItem = UITabBarItem(title: "Regiones", image: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait"))
            
            let teamsNavigationController = UINavigationController()
            teamsNavigationController.viewControllers = [teamsHome]
            teamsNavigationController.tabBarItem = UITabBarItem(title: "Mis Equipos", image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
            
            homeVc.setViewControllers([newNavigationController,teamsNavigationController], animated: true)
            homeVc.modalPresentationStyle = .fullScreen
            navigationConroller.present(homeVc, animated: false)
        }
        
    }
    
    static func createModule() -> ViewController {
        let view = storyBoard.instantiateViewController(identifier: "ViewController") as! ViewController
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = LogInPresenter()
        let interactor: PresenterToInteractorProtocol = LogInInteractor()
        let router:PresenterToRouterProtocol = LogInRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

}
