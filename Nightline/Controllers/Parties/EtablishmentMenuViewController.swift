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

    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpConsommableArray()
        getMenu()

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

    func getMenu() {
        firstly {
            establishmentInstance.getEstablishmentMenus(idEstablishment: bar_id)
            }.then { result -> Void in
                self.menuList = result
                print(result)
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
        if let liste = menus {
            return liste[section].conso!.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifer)
//        cell.textLabel?.text = array[indexPath.row].name!
//        let price = String(format: "%.02f €", array[indexPath.row].price!)
//        if array[indexPath.row].price! > 12 {
//            cell.detailTextLabel?.textColor = .red
//        }
//        cell.detailTextLabel?.text = price
//        cell.selectionStyle = .none
        print("Conso section \(indexPath.section), row \(indexPath.row)")
        print("\(menuList!.menus[indexPath.section].conso?[indexPath.row].name)")
        print("\(menuList!.menus[indexPath.section].conso?[indexPath.row].price)")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
