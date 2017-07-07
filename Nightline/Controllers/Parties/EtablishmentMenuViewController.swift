//
//  EtablishmentMenuViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 23/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import PageMenu


class EtablishmentMenuViewController: BaseViewController {
  
  var tableView: UITableView!
  var array = [Consommable]()
  
  let reuseIdentifer = "ConsommableCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpConsommableArray()
    
    tableView = UITableView(frame: self.view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(view).offset(UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!)
      make.bottom.equalTo(view)
      make.width.equalTo(view)
    }
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.reloadData()
  }
  
  private func setUpConsommableArray() {
    for i in 0...15 {
      let consommable = Consommable()
      consommable.name = "Consommable \(i)"
      consommable.price = Float(Double(arc4random_uniform(30)) + 0.99)
      array.append(consommable)
    }
  }
}

extension EtablishmentMenuViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
    cell.textLabel?.text = array[indexPath.row].name!
    let price = String(format: "%.02f €", array[indexPath.row].price!)
    if array[indexPath.row].price! > 12 {
      cell.detailTextLabel?.textColor = .red
    }
    cell.detailTextLabel?.text = price
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    return
  }
}
