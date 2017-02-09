//
//  UserSettingsTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/01/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

class UserSettingsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let reuseIdentifier = "SettingsCell"
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTableView()
  }
  
  private func addTableView() {
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isUserInteractionEnabled = false
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count = 0
    switch section {
    case SettingsCell.Profile.rawValue:
      count = 1
    case SettingsCell.Preference.rawValue:
      count = 2
    case SettingsCell.Info.rawValue:
      count = 3
    case SettingsCell.Logout.rawValue:
      return 1
    default:
      count = 0
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    if indexPath.section == SettingsCell.Profile.rawValue {
      let profileCell = UserProfileCell()
      profileCell.labelName.text = "Alex Odet"
      return profileCell
    } else {
      if indexPath.section == SettingsCell.Preference.rawValue {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = "Préférences \(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
      } else if indexPath.section == SettingsCell.Info.rawValue {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = "Infos \(indexPath.row)"
      } else {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = "Se déconnecter"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == SettingsCell.Profile.rawValue {
      return 90
    }
    return UITableViewAutomaticDimension
  }
  
  func performLogoutAction() {
    if let nav = self.navigationController {
      nav.popToRootViewController(animated: true)
    }
    Utils.Network.logOutUser()
  }
}
