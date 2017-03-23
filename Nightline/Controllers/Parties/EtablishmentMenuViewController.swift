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

class EtablishmentMenuViewController: BaseViewController {
  
  var consommableCollectionView: UICollectionView!
  var arrayItem = Array<String>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initArray()
  }
  
  func initArray() {
    for index in 0...13 {
      arrayItem.append("Item: \(index)")
    }
  }
}
