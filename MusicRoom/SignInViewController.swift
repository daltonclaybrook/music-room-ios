//
//  SignInViewController.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 10/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: class {
    func signInViewControllerCancelled(_ controller: SignInViewController)
    func signInViewControllerSignedIn(_ controller: SignInViewController)
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    weak var delegate: SignInViewControllerDelegate?
    
    //MARK: Actions
    
    @IBAction func signIn(_ sender: Any) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.signInViewControllerCancelled(self)
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
