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
  
  var consommableCollectionView: UICollectionView!
  var arrayItem = Array<String>()
  var pageMenu: CAPSPageMenu?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpPageView()
  }
  
  private func setUpPageView() {
    var controllers = [UIViewController]()
    let consos = Consommation.unknown.getAllConsommationTypes()
    
    for conso in consos {
      if conso != .unknown {
        let controller = ConsommationTypeCollectionViewController()
        controller.title = conso.toString()
        controllers.append(controller)
      }
    }
    let parameters: [CAPSPageMenuOption] = [
      .useMenuLikeSegmentedControl(true),
      .menuItemSeparatorPercentageHeight(0.1)
    ]
    pageMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0.0,y: 60,width: self.view.frame.width * 2, height: self.view.frame.height), pageMenuOptions: parameters)
    self.view.addSubview((pageMenu?.view)!)
    log.debug("OK")
  }
}
