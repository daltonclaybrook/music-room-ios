//
//  DatabaseManager.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/2/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class DatabaseManager {
    
    static var shared = DatabaseManager()
    
    func observeRooms(with block: ([Room]) -> ()) {
//        guard let userID = FIRAuth.auth()?.currentUser?.uid else { assertionFailure("user is not authenticated"); return }
        let reference = FIRDatabase.database().reference()
        reference.child("rooms")
            .queryStarting(atValue: "fizzbuzz")
            .queryEnding(atValue: "fizzbuzz")
            .observe(.value, with: { snapshot in
                print("finished fetching snapshot: \(snapshot.value)")
            })
        
//        reference.child("rooms").queryEqual(toValue: userID, childKey: "owner").observe(.value, with: { (snapshot: FIRDataSnapshot) in
//            print("")
//        })
    }
}
