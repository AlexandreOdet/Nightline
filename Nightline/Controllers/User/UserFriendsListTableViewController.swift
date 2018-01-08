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
import PromiseKit

final class UserFriendsListTableViewController: UITableViewController {

    private let anim = Animation()
    private let reuseIdentifier = "UserFriendsListCell"
    let friendsInstance = RAFriends()
    let invits = RAInvitations()
    var friendList: FriendsList?
    var pendingList = [Invitation]()

    deinit {
        friendsInstance.cancelRequest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        getData()
    }

    func getData() {
        getInvits()
        getFriends()
    }

    func getFriends() {
        firstly {
            friendsInstance.getUserFriendsList(userId: String(UserManager.instance.retrieveUserId()))
            }.then { [weak self] result -> Void in
                guard let strongSelf = self else { return }
                strongSelf.friendList = result
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }.catch { error -> Void in
                // Handle error?
        }
    }

    func getInvits() {
        firstly {
            invits.getUserInvitations(userID: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                self.pendingList = result.invitations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.catch { (error) in
                print(error.localizedDescription)
        }
    }

    func acceptInvit(invitId: String) {
        invits.acceptUserInvitation(invitationID: invitId) { response in
            switch response {
            case .success:
                self.getData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func declineInvit(invitId: String) {
        invits.declineUserInvitation(invitationID: invitId) { response in
            switch response {
            case .success:
                self.getInvits()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if pendingList.count >= 1 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if pendingList.count > 0{
                return pendingList.count
            } else if let fl = friendList, fl.friends.count > 0 {
                return fl.friends.count
            } else {
                return 1
            }
        default:
            if let fl = friendList {
                return fl.friends.count
            } else {
                return 0
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if pendingList.count > 0 {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, InvitUser: pendingList[indexPath.row].from)
                return cell
            } else if let fl = friendList, fl.friends.count > 0 {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, user: fl.friends[indexPath.row])
                return cell
            } else {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, user: nil)
                return cell
            }
        default:
            if let fl = friendList, fl.friends.count > 0 {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, user: fl.friends[indexPath.row])
                return cell
            }else {
                let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, user: nil)
                return cell
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if pendingList.count > 0 {
                answerInvitation(name: pendingList[indexPath.row].from.pseudo, id: pendingList[indexPath.row].id)
            } else if let fl = friendList, fl.friends.count > 0 {
                let userInstance = RAUser()
                firstly {
                    userInstance.getUserInfos(id: String(fl.friends[indexPath.row].id))
                    }.then { [weak self] result -> Void in
                        guard let strongSelf = self else { return }
                        DispatchQueue.main.async {
                            strongSelf.presentUserDetails(user: result.user)
                        }
                    }.catch { error -> Void in
                        print(error)
                }
            } else {
                return
            }
        default:
            if let fl = friendList, fl.friends.count > 0 {
                let userInstance = RAUser()
                firstly {
                    userInstance.getUserInfos(id: String(fl.friends[indexPath.row].id))
                    }.then { [weak self] result -> Void in
                        guard let strongSelf = self else { return }
                        DispatchQueue.main.async {
                            strongSelf.presentUserDetails(user: result.user)
                        }
                    }.catch { error -> Void in
                        print(error)
                }
            }
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

    func answerInvitation(name: String, id: Int) {
        let answerView = UIAlertController(title: name, message: "souhaite rejoindre votre liste d'amis", preferredStyle: .actionSheet)
        answerView.addAction(UIAlertAction(title: "Accepter", style: .default) {
            _ in
            // Accept friend
            self.acceptInvit(invitId: String(id))
            self.getData()
        })
        answerView.addAction(UIAlertAction(title: "Refuser", style: .destructive) {
            _ in
            // Refuse friend
            self.declineInvit(invitId: String(id))
            self.getInvits()
        })
        present(answerView, animated: true, completion: nil)
    }

    func presentUserDetails(user: User) {
        let nextVC = DetailUserViewController()
        nextVC.user = user
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
