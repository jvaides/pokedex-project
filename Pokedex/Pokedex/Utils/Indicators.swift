//
//  Indicators.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 28/06/22.
//

import Foundation
import UIKit


/* Show Progress Indicator */
func showProgressIndicator(view:UIView){
    DispatchQueue.main.async {
        view.isUserInteractionEnabled = false
        
        let visualEffectView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 90.0, height: 90.0))
        visualEffectView.center = view.center
        visualEffectView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9490196078, alpha: 0.5)
        visualEffectView.isHidden = false
        view.addSubview(visualEffectView)
        view.bringSubviewToFront(visualEffectView)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 25, y: 25, width: 45, height: 45)
        activityIndicator.hidesWhenStopped = true
        visualEffectView.addSubview(activityIndicator)
        visualEffectView.tag = 1
        visualEffectView.center = view.center
        //activityIndicator?.center = self.view.center
        visualEffectView.layer.cornerRadius = 6.0
        visualEffectView.clipsToBounds = true
        activityIndicator.startAnimating()
    }

    
}

/* Hide progress Indicator */
func hideProgressIndicator(view:UIView){
    DispatchQueue.main.async {
        view.isUserInteractionEnabled = true
        
        if let viewWithTag = view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
        }
    }

    
}


func showAlertMessage(message:String, viewController: UIViewController) {
    DispatchQueue.main.async {
        let alertMessage = UIAlertController(title: "", message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)

        alertMessage.addAction(cancelAction)

        viewController.present(alertMessage, animated: true, completion: nil)
    }
}
func showAlertView(message:String,title:String, alertType: Int?,viewController: UIViewController){
    DispatchQueue.main.async {
        let alertview = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            return
        }

        if alertType != 5{
            alertview.addAction(okAction)

        }
        
            //self.present(alertview, animated: true, completion: nil)
        viewController.present(alertview, animated: true, completion: nil)
    }
}
