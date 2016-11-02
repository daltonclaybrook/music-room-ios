//
//  CreateRoomOperation.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation
import ProcedureKit
import FirebaseAuth
import FirebaseDatabase

class CreateRoomOperation: Procedure, ResultInjection {
    typealias Requirement = Void
    typealias Result = String
    
    var requirement: PendingValue<Void> = .void
    var result: PendingValue<String> = .pending
    private let roomName: String
    
    init(roomName: String) {
        self.roomName = roomName
        super.init()
    }
    
    override func execute() {
        guard !isCancelled else { return }
        
//        let ref = FIRDatabase.database().reference()
//        guard let owner = FIRAuth.auth()?.currentUser?.uid else { finish() }
//        
//        ref.child("rooms").childByAutoId().setValue(<#T##value: Any?##Any?#>)
    }
}
