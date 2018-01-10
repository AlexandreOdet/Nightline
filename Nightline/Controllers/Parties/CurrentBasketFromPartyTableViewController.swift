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
import TTGSnackbar
import PromiseKit

class CurrentBasketFromPartyTableViewController: BaseViewController {
  
  let cellIdentifier = "BasketCell"
  
  let paymentInstance = RAPayment()
  
  var consommableItems = [Consommable]()
  var usersItems = [User]()
  
  var tableView: UITableView!
  
  deinit {
    paymentInstance.cancelRequest()
    NotificationCenter.default.removeObserver(self)
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
    NotificationCenter.default.addObserver(self, selector: #selector(basketEmptinessHasChanged),
                                           name: Notification.Name(rawValue: "BasketHasChanged"), object: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpRightBarButtonItem()
    tableView = UITableView(frame: view.frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalToSuperview()
    }
  }
  
  private func setUpRightBarButtonItem() {
    let barButtonItem = UIBarButtonItem(image: R.image.checked(), style: .plain,
                                        target: self, action: #selector(didTapRightBarButtonItem))
    navigationItem.rightBarButtonItem = barButtonItem
  }
  
  @objc func basketEmptinessHasChanged() {
    //To-Do
    navigationItem.rightBarButtonItem?.isEnabled = !Basket.manager.isBasketEmpty
    if Basket.manager.isBasketEmpty {
      consommableItems.removeAll()
      tableView.reloadData()
    }
  }
  
  @objc func didTapRightBarButtonItem() {
    let alert = UIAlertController(title: "Confirmez-vous votre panier ?", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Passer commande !", style: .default, handler: {
      [unowned self] _ in
      Basket.manager.orderToString()
      firstly {
        self.paymentInstance.orderInParty(order: Basket.manager.order)
        }.then { resp -> Void in
          print(resp.order.id)
          DispatchQueue.main.async {
            let snackbar = TTGSnackbar(message: "Votre commande a bien été envoyée. Vous allez recevoir une demande de paiement.", duration: .long)
            snackbar.show()
          }
        }.catch { _ in
          DispatchQueue.main.async {
            let snackbar = TTGSnackbar(message: "Oups... Il y'a eu une erreur de notre côté.", duration: .long)
            snackbar.show()
          }
      }
    }))
    alert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension CurrentBasketFromPartyTableViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      if !Basket.manager.isBasketEmpty{
        return "Mes consos"
      } else {
        return "Votre panier est vide."
      }
    }
    return ""
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return consommableItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
    if indexPath.row < consommableItems.count {
      let textAmount = Basket.manager.getAmountOfConsommable(consommableID: consommableItems[indexPath.row].id!)
      cell.textLabel?.text = "\(consommableItems[indexPath.row].name ?? "") x \(textAmount)"
      let amountOfConso = Float(Basket.manager.getAmountOfConsommable(consommableID: consommableItems[indexPath.row].id!))
      let totalPriceForConso = amountOfConso * (consommableItems[indexPath.row].price ?? -1)
      cell.detailTextLabel?.text = "\(totalPriceForConso) €"
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if indexPath.row < consommableItems.count {
      return true
    }
    return false
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    if indexPath.row < consommableItems.count {
      let amountofConso = Basket.manager.getAmountOfConsommable(consommableID: consommableItems[indexPath.row].id!)
      if amountofConso > 1 {
        let deleteOne = UITableViewRowAction(style: .normal, title: "Supprimer une", handler: {
          action, indexPath in
          Basket.manager.removeConsommableFromOrder(consommableID: self.consommableItems[indexPath.row].id!)
          self.tableView.reloadData()
        })
        deleteOne.backgroundColor = UIColor.nightlineAccent
        let deleteAll = UITableViewRowAction(style: .normal, title: "Supprimer toutes", handler: {
          action, indexPath in
          //Basket.manager.removeConsommableFromOrder(consommableID: self.consommableItems[indexPath.row].id!)
          let integerPrice = Int((self.consommableItems[indexPath.row].price ?? -1)  * 100)
          Basket.manager.removeAllConsommable(consommableID: self.consommableItems[indexPath.row].id!, price: integerPrice)
          self.consommableItems.remove(at: indexPath.row)
          self.tableView.reloadData()
        })
        return [deleteOne, deleteAll]
      } else {
        let deleteOne = UITableViewRowAction(style: .normal, title: "Supprimer du panier", handler: {
          action, indexPath in
          Basket.manager.removeConsommableFromOrder(consommableID: self.consommableItems[indexPath.row].id!)
          self.consommableItems.remove(at: indexPath.row)
          self.tableView.reloadData()
        })
        return [deleteOne]
      }
    }
    return []
  }
}

