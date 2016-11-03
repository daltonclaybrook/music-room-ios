//
//  Room.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import Foundation

struct Room {
    let name: String
    let owner: String
    let participantCount: Int
    let nowPlaying: String?
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "owner": owner,
            "participantCount": participantCount,
            "nowPlaying": nowPlaying as Any
        ]
    }
}
