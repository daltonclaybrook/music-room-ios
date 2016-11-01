//
//  ViewController.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 10/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import Firebase

let SignInSegue = "SignInSegue"

class HomeViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SignInSegue,
            let navController = segue.destination as? UINavigationController,
            let signInController = navController.topViewController as? SignInViewController {
            
            signInController.delegate = self
        }
    }
}

extension HomeViewController: SignInViewControllerDelegate {
    
    func signInViewControllerSignedIn(_ controller: SignInViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func signInViewControllerCancelled(_ controller: SignInViewController) {
        dismiss(animated: true, completion: nil)
    }
}
