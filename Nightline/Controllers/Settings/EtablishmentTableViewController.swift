//
//  EtablishmentTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/*
 Controllers: EtablishmentTableViewController
 This controller show a UITableView containing all etablishement types.
 */

final class EtablishmentTableViewController: UITableViewController {
  
  let reuseIdentifier = "EtablishmentCell"
  let array = Etablishment.unknown.getAllEtablishmentType()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
    self.title = R.string.localizable.etabl()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
    cell.textLabel?.text = self.array[indexPath.row].toString()
    cell.selectionStyle = .none
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.onClick()
      if cell.accessoryType == .none {
        cell.accessoryType = .checkmark
      } else {
        cell.accessoryType = .none
      }
    }
  }
  
}
