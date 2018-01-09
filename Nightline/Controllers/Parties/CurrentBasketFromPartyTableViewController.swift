//
//  CurrentBasketFromPartyTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CurrentBasketFromPartyTableViewController: BaseViewController {
  
  let cellIdentifier = "BasketCell"
  
  let paymentInstance = RAPayment()
  
  var consommableItems = [Consommable]()
  var usersItems = [User]()
  
  var tableView: UITableView!
  
  deinit {
    paymentInstance.cancelRequest()
  }
  
  init(with consos: [Consommable]) {
    super.init(nibName: nil, bundle: nil)
    for conso in consos {
      for consommable in Basket.manager.order.consos {
        if consommable.consos.id == conso.id {
          consommableItems.append(conso)
        }
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalToSuperview()
    }
  }
  
//  func mapConsommableFromBasket() {
//    //let output = fruitsArray.filter(vegArray.contains)
//  }
  
  func mapUserfromBasket() {
    
  }
}

extension CurrentBasketFromPartyTableViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return consommableItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
    if indexPath.row < consommableItems.count {
      cell.textLabel?.text = consommableItems[indexPath.row].name ?? ""
      cell.detailTextLabel?.text = "\(consommableItems[indexPath.row].price ?? -1) €"
    }
    return cell
  }
}

