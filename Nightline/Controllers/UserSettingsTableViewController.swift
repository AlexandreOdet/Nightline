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
  
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTableView()
  }
  
  private func addTableView() {
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func performLogoutAction() {
    if let nav = self.navigationController {
      nav.popToRootViewController(animated: true)
    }
    Utils.Network.logOutUser()
  }
}
