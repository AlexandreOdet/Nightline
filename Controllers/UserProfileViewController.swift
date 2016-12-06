
//
//  UserProfileViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class UserProfileViewController: BaseViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.backgroundColor = UIColor.white
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
