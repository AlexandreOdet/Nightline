//
//  MoreTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 13/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MoreTableViewController: BaseViewController {
  let reuseIdentifier = "moreTableViewCell"
  let cellTitles = [R.string.localizable.settings(), "Echo", "Messagerie", "Notification"]
  
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  func setUpView() {
    tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalToSuperview()
    }
  }
}

extension MoreTableViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellTitles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    cell.accessoryType = .disclosureIndicator
    if indexPath.row > 1 {
      cell.selectionStyle = .none
    }
    cell.textLabel?.text = cellTitles[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let nextViewController = UserSettingsTableViewController()
      navigationController?.pushViewController(nextViewController, animated: true)
    } else if indexPath.row == 1 {
      let nextViewController = EchoTableViewController()
      navigationController?.pushViewController(nextViewController, animated: true)
    } else {
      log.debug("Not implemented yet")
    }
  }
  
}
