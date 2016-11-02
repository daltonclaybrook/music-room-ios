//
//  PresentableError.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation

protocol PresentableError: Error {
    var title: String { get }
    var message: String { get }
}

extension PresentableError {
    var title: String {
        return "Oops"
    }
    var message: String {
        return "An unknown error occurred."
    }
}

struct UnknownError: PresentableError {}
