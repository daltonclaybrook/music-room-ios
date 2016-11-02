//
//  SignInViewController.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 10/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit
import ProcedureKit

protocol SignInViewControllerDelegate: class {
    func signInViewControllerCancelled(_ controller: SignInViewController)
    func signInViewControllerSignedIn(_ controller: SignInViewController)
}

class SignInViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    weak var delegate: SignInViewControllerDelegate?
    let operationQueue = ProcedureQueue()
    private let loadingView = LoadingView()
    
    //MARK: Superclass
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        emailField.text = "daltonclaybrook@gmail.com"
        passwordField.text = "password"
        #endif
    }
    
    //MARK: Actions
    
    @IBAction func signIn(_ sender: Any) {
        executeSignWith(create: false)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        executeSignWith(create: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.signInViewControllerCancelled(self)
    }
    
    //MARK: Private
    
    private func executeSignWith(create: Bool) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text,
            let password = passwordField.text,
            email.characters.count > 0,
            password.characters.count > 0 else { showEmptyFieldAlert(); return }
        
        loadingView.showInView(view: view)
        let operation = SignInOperation(email: email, password: password, createAccount: create)
        operation.addDidFinishBlockObserver { [weak self] (operation, errors) in
            guard let strongSelf = self else { return }
            strongSelf.loadingView.hide()
            
            if case .ready(_) = operation.result {
                strongSelf.delegate?.signInViewControllerSignedIn(strongSelf)
            } else if let error = errors.first {
                strongSelf.showAlertForError(error: error)
            }
        }
        operationQueue.add(operation: operation)
    }
    
    private func showEmptyFieldAlert() {
        let alert = UIAlertController(title: "Oops", message: "One or more fields are blank", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertForError(error: Error) {
        let authError = error as? PresentableError ?? UnknownError()
        let alert = UIAlertController(title: authError.title, message: authError.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
