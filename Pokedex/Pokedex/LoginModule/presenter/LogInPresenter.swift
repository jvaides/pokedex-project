//
//  LogInPresenter.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation
import FirebaseAuth
// MARK: ViewToPresenterProtocol
class LogInPresenter:ViewToPresenterProtocol{
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startDoingLogIn(credential:AuthCredential) {
        interactor?.doLogIn(credential: credential)
    }
    
    func showHomeViewController(userInfo:LogInModel,navigationConroller:ViewController) {
        //Do router actions
        router?.segueToHome(userInfo: userInfo, navigationConroller: navigationConroller)
    }
    
    
}
// MARK: InteractorToPresenterProtocol
extension LogInPresenter:InteractorToPresenterProtocol{
    func noticeLogInSucceed(userInfo: LogInModel) {
        
        view?.showHomeWithLogInInfo(userInfo: userInfo)
    }
    
    func logInFailed(error:Error) {
        view?.showError(error: error)
    }
    
    
}
