//
//  SignInOperation.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 10/31/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation
import ProcedureKit
import FirebaseAuth

class SignInOperation: Procedure, ResultInjection {
    
    typealias Requirement = Void
    typealias Result = FIRUser
    
    var requirement: PendingValue<Void>
    var result: PendingValue<FIRUser>
    
    private let email: String
    private let password: String
    private let createAccount: Bool
    
    init(email: String, password: String, createAccount: Bool) {
        self.email = email
        self.password = password
        self.createAccount = createAccount
        
        requirement = .void
        result = .pending
        super.init()
    }
    
    //MARK: Superclass
    
    override func execute() {
        guard !isCancelled else { return }
        
        if let signInFunction = createAccount ? FIRAuth.auth()?.createUser : FIRAuth.auth()?.signIn {
            signInFunction(email, password) { [weak self] (user, error) in
                self?.finish(with: user, error: error)
            }
        }
    }
    
    //MARK: Private
    
    func finish(with user: FIRUser?, error: Error?) {
        if let user = user {
            result = .ready(user)
            finish()
        } else if let error = error {
            finish(withErrors: [error])
        }
    }
}
