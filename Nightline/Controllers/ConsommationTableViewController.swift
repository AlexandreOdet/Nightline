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

final class ConsommationTableViewController: UITableViewController {
  
  private let reuseIdentifier = "consommationCell"
  let array = Consommation.unknown.getAllConsommationTypes()
  let userConsommationPreferences = UserManager.instance.getUserConsommationPreferences()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = R.string.localizable.drinks()
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
    showUserConsoArray()
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
    cell.selectionStyle = .none
    if self.isConsommationInUserPreferences(conso: array[indexPath.row].rawValue) {
      cell.accessoryType = .checkmark
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.onClick()
      if cell.accessoryType == .checkmark {
        cell.accessoryType = .none
        UserManager.instance.removeConsommationFromuserPreferences(conso: array[indexPath.row].rawValue)
      } else {
        cell.accessoryType = .checkmark
        UserManager.instance.addConsommationToUserPreferences(conso: array[indexPath.row].rawValue)
      }
    }
  }
  
  private func isConsommationInUserPreferences(conso: String) -> Bool {
    for consommation in userConsommationPreferences {
      if consommation == conso {
        return true
      }
    }
    return false
  }
  
  private func showUserConsoArray() {
    for conso in userConsommationPreferences {
      print(conso)
    }
  }
  
}
