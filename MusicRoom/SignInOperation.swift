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

enum AuthError {
    case unknown
    case wrongPassword
    case weakPassword
    case userNotFound
    case emailInUse
    case invalidEmail
    
    init(firError: Error) {
        guard let code = FIRAuthErrorCode(rawValue: (firError as NSError).code) else { self = .unknown; return }
        switch code {
        case .errorCodeWrongPassword:
            self = .wrongPassword
        case .errorCodeUserNotFound:
            self = .userNotFound
        case .errorCodeWeakPassword:
            self = .weakPassword
        case .errorCodeEmailAlreadyInUse:
            self = .emailInUse
        case .errorCodeInvalidEmail:
            self = .invalidEmail
        default:
            self = .unknown
            print("auth error code: \(code.rawValue)")
        }
    }
}

extension AuthError: PresentableError {
    var title: String {
        return "Oops"
    }
    var message: String {
        switch self {
        case .unknown:
            return "An unknown error occurred"
        case .wrongPassword:
            return "The password you entered was incorrect"
        case .weakPassword:
            return "The password you chose was too weak. It must be 6 characters long or more."
        case .userNotFound:
            return "A user with this email could not be found"
        case .emailInUse:
            return "This email is already in use"
        case .invalidEmail:
            return "The email address you entered is not valid"
        }
    }
}

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
            finish(withErrors: [AuthError(firError: error)])
        }
    }
}
