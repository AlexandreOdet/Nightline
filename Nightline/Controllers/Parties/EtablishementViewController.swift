//
//  EtablishementViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class EtablishmentViewController: ProfileViewController {
  override func viewDidLoad() {
    self.isUser = false
    self.imgHeader.image = R.image.bar()
    super.viewDidLoad()
    self.imgProfile.image = R.image.test_logo()
  }
}
