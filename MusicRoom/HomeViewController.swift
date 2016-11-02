//
//  HomeViewController.swift
//  MusicRoom
//
//  Created by Dalton Claybrook on 11/1/16.
//  Copyright © 2016 Claybrook Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        
        rooms = [
            Room(name: "Party", owner: "d4ltr0n", participantCount: 4, nowPlaying: "Fart by Lady Gaga"),
            Room(name: "Dance", owner: "drew", participantCount: 4, nowPlaying: "Tits by Fart"),
            Room(name: "H00d R4Tz", owner: "p4t5y", participantCount: 4, nowPlaying: "Ass by Bey")
        ]
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.reuseID, for: indexPath)
        if let cell = cell as? RoomCell {
            cell.configure(with: rooms[indexPath.row])
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
}
