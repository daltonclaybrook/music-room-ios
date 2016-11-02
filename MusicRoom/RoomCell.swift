//
//  RoomCell.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    static var reuseID: String {
        return String(describing: RoomCell.self)
    }
    
    func configure(with room: Room) {
        nameLabel.text = room.name
        ownerLabel.text = room.owner
        peopleCountLabel.text = room.participantCount == 1 ? "1 person inside" : "\(room.participantCount) people inside"
        nowPlayingLabel.text = "now playing \(room.nowPlaying)"
    }
}
