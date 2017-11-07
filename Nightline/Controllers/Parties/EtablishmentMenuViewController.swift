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
import PromiseKit

class EtablishmentMenuViewController: BaseViewController {

    var tableView: UITableView!
    var bar_id: String = ""
    let establishmentInstance = RAEtablissement()
    var menuList: MenuList? = nil

    //var array = [Consommable]()
    var array = [
        Consommable(name: "Leff pression (25cl)", price: 3.5),
        Consommable(name: "Leff pression (50cl)", price: 6.5),
        Consommable(name: "1664 pression (25cl)", price: 3),
        Consommable(name: "1664 pression (50cl)", price: 5.5),
        Consommable(name: "Guiness pression (25cl)", price: 4),
        Consommable(name: "Guiness pression (50cl)", price: 7),
        Consommable(name: "Whisky (4cl)", price: 8),
        Consommable(name: "Mojito (petit)", price: 5),
        Consommable(name: "Mojito (grand)", price: 7),
        Consommable(name: "Margarita (25cl)", price: 5),
        Consommable(name: "Margarita (1L)", price: 16),
        Consommable(name: "Cola", price: 3.5),
        Consommable(name: "Tea glacé", price: 3),
        Consommable(name: "Limonade", price: 3)
    ]

    let reuseIdentifer = "ConsommableCell"
  
  deinit {
    establishmentInstance.cancelRequest()
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpConsommableArray()
        getMenu()

        tableView = UITableView(frame: view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!)
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.reloadData()
    }

    func getMenu() {
        firstly {
            establishmentInstance.getEstablishmentMenus(idEstablishment: bar_id)
            }.then { [weak self] result -> Void in
              guard let strongSelf = self else { return }
                strongSelf.menuList = result
                print(result)
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }.catch { error -> Void in
                print(error)
        }
    }
}

extension EtablishmentMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if menuList != nil {
            return menuList!.menus.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let liste = menuList?.menus {
            return liste[section].conso?.count ?? 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return menuList!.menus[section].name
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
        cell.textLabel?.text = menuList!.menus[indexPath.section].conso?[indexPath.row].name
        let price = String(format: "%.02f €", (menuList!.menus[indexPath.section].conso?[indexPath.row].price)!)
        if array[indexPath.row].price! > 12 {
            cell.detailTextLabel?.textColor = .red
        }
        cell.detailTextLabel?.text = price
        cell.selectionStyle = .none
        print("Conso section \(indexPath.section), row \(indexPath.row)")
        print("\(String(describing: menuList!.menus[indexPath.section].conso?[indexPath.row].name))")
        print("\(String(describing: menuList!.menus[indexPath.section].conso?[indexPath.row].price))")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
