//
//  LogInInteractor.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class LogInInteractor:PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func doLogIn(credential:AuthCredential) {
        appDelegate.auth?.signIn(with: credential) { authResult, error in
            if let error = error {
                
                let authError = error as NSError
                self.presenter?.logInFailed(error: authError)
                
                
            }
            let newUser = LogInModel(name: authResult?.user.displayName ?? "", lastName: authResult?.user.displayName ?? "", email: authResult?.user.email ?? "", userImage: authResult?.user.photoURL ?? URL(string: ""))
            self.presenter?.noticeLogInSucceed(userInfo: newUser)
        }
    }
    
}
