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

class UserSettingsTableViewController: UIViewController {
  
  var logoutButton = UIButton()
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addLogoutButtonToView()
  }
  
  private func addLogoutButtonToView() {
    self.view.addSubview(logoutButton)
    logoutButton.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.width.equalTo(self.view)
      make.height.equalTo(50)
    }
    logoutButton.backgroundColor = UIColor.white
    logoutButton.setTitle(R.string.localizable.logout(), for: .normal)
    logoutButton.addTarget(self, action: #selector(performLogoutAction), for: .touchUpInside)
    logoutButton.setTitleColor(.red, for: .normal)
  }
  
  func performLogoutAction() {
    if let nav = self.navigationController {
      nav.popToRootViewController(animated: true)
    }
    Utils.Network.logOutUser()
  }
}
