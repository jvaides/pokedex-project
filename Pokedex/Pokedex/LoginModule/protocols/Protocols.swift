//
//  Protocols.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ViewToPresenterProtocol:AnyObject{
    /**
     This  is a property variable to make a reference to PresenterToViewProtocol
     */
    var view:PresenterToViewProtocol? { get set }

    /**
     This  is a property variable to make a reference to PresenterToInteractorProtocol
     */
    var interactor:PresenterToInteractorProtocol? { get set }

    /**
     This  is a property variable to make a reference to PresenterToRouterProtocol
     */
    var router:PresenterToRouterProtocol? { get set }

    /**
     This method  asks the interactor to do the login
     - parameter credential: The Firebase auth credential received from API
     */
    func startDoingLogIn(credential:AuthCredential)

    /**
     This method  asks the interactor to do the login
     - parameter userInfo: The profile information receved from user login
     - parameter navigationController:The navigation controller from where the next view will be presented
     */
    func showHomeViewController(userInfo:LogInModel,navigationConroller:ViewController)
}

protocol PresenterToViewProtocol:AnyObject{
    /**
     This method is used in Presenter to inform the view to update
     - parameter userInfo: The profile information received from user login comming from presenter
     */
    func showHomeWithLogInInfo(userInfo:LogInModel)

    /**
     This method is used in Presenter to inform the view to update and show error
     - parameter error: An Error returned from user login
     */
    func showError(error:Error)
}

protocol PresenterToRouterProtocol:AnyObject{
    /**
     This method is used to create an instance of type ViewController
     */
    static func createModule() -> ViewController

    /**
     This method is used to move from current VC to another
     - parameter userInfo:The information received from user login
     - parameter navigationController: The navigation controller from wich the new view will be presented or pushed
     */
    func segueToHome(userInfo:LogInModel,navigationConroller:ViewController)
}

protocol PresenterToInteractorProtocol:AnyObject{
    /**
     This  is a property variable to make a reference to InteractorToPresenterProtocol
     */
    var presenter:InteractorToPresenterProtocol? {get set}
    /**
     This is a method  used for tell the Interactor to start doing the login
     - parameter credential:  The Firebase auth credential received from API
     */
    func doLogIn(credential:AuthCredential)
}

protocol InteractorToPresenterProtocol:AnyObject{
    /**
     This method is used to inform the presenter that user login completed successfully
     - parameter credential:  The Firebase auth credential received from API
     */
    func noticeLogInSucceed(userInfo:LogInModel)

    /**
     This method is used in Presenter to inform the view to update and show error
     - parameter error: An Error returned from user login
     */
    func logInFailed(error:Error)
}
