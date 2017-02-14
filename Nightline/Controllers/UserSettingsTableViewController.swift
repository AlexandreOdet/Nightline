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
    self.title = R.string.localizable.settings()
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
      profileCell.isUserInteractionEnabled = true //soon édition du profil
        
      return profileCell
    } else {
      if indexPath.section == SettingsCell.Preference.rawValue {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = (indexPath.row == 0) ? R.string.localizable.etabl() : R.string.localizable.drinks()
        cell.accessoryType = .disclosureIndicator
      } else if indexPath.section == SettingsCell.Info.rawValue {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = "Infos \(indexPath.row)"
        cell.isUserInteractionEnabled = false
      } else {
        cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        cell.textLabel?.text = R.string.localizable.logout()
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
      }
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == SettingsCell.Preference.rawValue {
      if indexPath.row == 0 {
        let nextViewController = EtablishmentTableViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      } else {
        let nextViewController = ConsommationTableViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      }
    } else if indexPath.section == SettingsCell.Logout.rawValue {
      self.performLogoutAction()
    } else if indexPath.section == SettingsCell.Profile.rawValue {
        self.goToEditProfilViewController()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == SettingsCell.Profile.rawValue {
      return 90
    }
    return UITableViewAutomaticDimension
  }
  
  func performLogoutAction() {
    Utils.Network.logOutUser()
    let notificationName = Notification.Name(TabBarController.notificationIdentifier)
    NotificationCenter.default.post(name: notificationName, object: nil)
  }
    
    func goToEditProfilViewController() {
        let nextViewController = EditProfileViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
