//
//  ViewController.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {
    
    var presentor:ViewToPresenterProtocol?
    var userInfo:LogInModel?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var logInButton: GIDSignInButton!
    
    @IBOutlet weak var welcomeTitle: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeTitle.setPokemonTitle()
        let tap = UITapGestureRecognizer(target: self, action: #selector(fetchGoogleAccountCredentials))
        self.logInButton.addGestureRecognizer(tap)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    
    @objc
    func fetchGoogleAccountCredentials(){
        guard let clientID = appDelegate.fir_app?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                // ...
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            showProgressIndicator(view: self.view)
            presentor?.startDoingLogIn(credential: credential)
        }
        
    }
}

extension ViewController:PresenterToViewProtocol{
    func showHomeWithLogInInfo(userInfo: LogInModel) {
        self.userInfo = userInfo
        hideProgressIndicator(view: self.view)
        presentor?.showHomeViewController(userInfo: userInfo, navigationConroller: self)
    }
    
    func showError(error:Error) {
        hideProgressIndicator(view: self.view)
        showAlertView(message: error.localizedDescription, title: "Lo Sentimos", alertType: 0, viewController: self)
    }
    
    
}
