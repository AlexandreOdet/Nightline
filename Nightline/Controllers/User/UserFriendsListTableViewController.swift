//
//  UserFriendsListTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 24/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class UserFriendsListTableViewController: UITableViewController {

    private let anim = Animation()
    private let reuseIdentifier = "UserFriendsListCell"
    var pendingList: [String] = ["pendingtoto", "pendingtiti", "Ptata", "Ptutu"]
    var friendList: [String] = ["toto", "titi", "tata", "tutu"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if pendingList.count > 0 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if pendingList.count > 0{
                return pendingList.count
            } else if friendList.count > 0 {
                return friendList.count
            } else {
                return 1
            }
        default:
            return friendList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if pendingList.count > 0 {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: pendingList[indexPath.row])
                return cell
            } else if friendList.count > 0 {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: friendList[indexPath.row])
                return cell
            } else {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: "No friend")
                return cell
            }
        default:
            let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: friendList[indexPath.row])
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if pendingList.count > 0{
                answerInvitation(name: pendingList[indexPath.row])
            } else if friendList.count > 0 {
                // show friend profile
            } else {
                return
            }
        default:
            return
            // show friend profile
        }
//        anim.onClick(sender: cell.contentView)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if pendingList.count > 0 {
                return "Invitations"
            } else {
                return "Amis"
            }
        default:
            return "Amis"
        }
    }

    func answerInvitation(name: String) {
        let answerView = UIAlertController(title: name, message: "souhaite rejoindre votre liste d'amis", preferredStyle: .actionSheet)
        answerView.addAction(UIAlertAction(title: "Accepter", style: .default) {
            _ in
            // Accept friend
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        answerView.addAction(UIAlertAction(title: "Refuser", style: .destructive) {
            _ in
            // Refuse friend
            if let ip = self.tableView.indexPathForSelectedRow {
                self.pendingList.remove(at: ip.row)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        present(answerView, animated: true, completion: nil)
    }
    
}
