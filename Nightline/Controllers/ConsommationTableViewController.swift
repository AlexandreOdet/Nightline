//
//  ConsommationTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ConsommationTableViewController: UITableViewController {
  
  private let reuseIdentifier = "consommationCell"
  let array = Consommation.unknown.getAllConsommationTypes()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = R.string.localizable.drinks()
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
    cell.textLabel?.text = array[indexPath.row].toString()
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .checkmark {
        cell.accessoryType = .none
      } else {
        cell.accessoryType = .checkmark
      }
    }
  }
  
}
