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
  
  var array = Array<String>()
  private let anim = Animation()
  private let reuseIdentifier = "UserFriendsListCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
    for i in 0...50 {
      array.append("User \(i)")
    }
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    self.tableView.reloadData()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UserFriendsListTableViewCell(reuseIdentifier: reuseIdentifier, nameUser: array[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else {
      return
    }
    anim.onClick(sender: cell.contentView)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
}
