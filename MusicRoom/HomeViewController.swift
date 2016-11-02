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
        tableView.estimatedRowHeight = 50
        
        rooms = [
            Room(name: "Party", owner: "d4ltr0n", participantCount: 4, nowPlaying: "Fart by Lady Gaga"),
            Room(name: "Dance", owner: "drew", participantCount: 1, nowPlaying: "Tits by Fart"),
            Room(name: "H00d R4Tz", owner: "p4t5y", participantCount: 0, nowPlaying: "Ass by Bey")
        ]
        tableView.reloadData()
    }
    
    //MARK: Actions
    
    @IBAction func addRoom(_ sender: Any) {
        let alert = UIAlertController(title: "Add Room", message: "Enter a name", preferredStyle: .alert)
        alert.addTextField { (field) in
            field.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Create", style: .default) { [weak self, weak alert] action in
            self?.addRoom(with: alert?.textFields?.first?.text ?? "")
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Private
    
    private func addRoom(with name: String) {
        
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
