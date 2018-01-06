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
  //    var pendingList: [String] = ["pendingtoto", "pendingtiti", "Ptata", "Ptutu"]
  //    var friendList: [String] = ["toto", "titi", "tata", "tutu"]
  let friendsInstance = RAFriends()
  var friendList: FriendsList?
  var pendingList: InvitationsList?
  
  deinit {
    friendsInstance.cancelRequest()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    //        self.tableView.reloadData()
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
      friendsInstance.getUserInvitationList(userId: String(UserManager.instance.retrieveUserId()))
      }.then { [weak self] result -> Void in
        guard let strongSelf = self else { return }
        strongSelf.pendingList = result
        DispatchQueue.main.async {
          strongSelf.tableView.reloadData()
        }
      }.catch { error -> Void in
        // Handle error?
    }
  }
  
  func acceptInvit(invitId: String) {
    //        firstly {
    //            let id = String(UserManager.instance.getUserId())
    //            friendsInstance.acceptInvitation(userId: id, invitationId: invitId)
    //            }.then { result -> Void in
    //                self.getData()
    //                return
    //            }
  }
  
  func declineInvit(invitId: String) {
    //        firstly {
    //            let id = String(UserManager.instance.getUserId())
    //            friendsInstance.declineInvitation(userId: id, invitationId: invitId)
    //            }.then { result -> Void in
    //                self.getData()
    //        }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if let pl = pendingList, pl.invitations.count >= 1 {
      return 2
    }
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      if let pl = pendingList, pl.invitations.count > 0{
        return pl.invitations.count
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
      if let pl = pendingList, pl.invitations.count > 0 {
        let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: pl.invitations[indexPath.row].from.pseudo)
        return cell
      } else if let fl = friendList, fl.friends.count > 0 {
        let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: fl.friends[indexPath.row].nickname)
        return cell
      } else {
        let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: "No friend")
        return cell
      }
    default:
      if let fl = friendList, fl.friends.count > 0 {
        let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: fl.friends[indexPath.row].nickname)
        return cell
      }else {
        let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: "No friend")
        return cell
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      if let pl = pendingList, pl.invitations.count > 0 {
        answerInvitation(name: pl.invitations[indexPath.row].from.pseudo)
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
      if let pl = pendingList, pl.invitations.count > 0 {
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
        if let ip = self.tableView.indexPathForSelectedRow, let pl = self.pendingList {
        pl.invitations.remove(at: ip.row)
      }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
    present(answerView, animated: true, completion: nil)
  }
  
  func presentUserDetails(user: User) {
    let nextVC = DetailUserViewController()
    nextVC.user = user
    navigationController?.pushViewController(nextVC, animated: true)
  }
}
