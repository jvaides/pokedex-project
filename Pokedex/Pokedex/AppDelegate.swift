//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 25/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var database_ref:DatabaseReference?
    var auth:Auth?
    var fir_app:FirebaseApp?
    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        database_ref = Database.database().reference()
        auth = Auth.auth()
        fir_app = FirebaseApp.app()
        

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)//handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        //return GIDSignIn.sharedInstance().handle(url)
    }
}

