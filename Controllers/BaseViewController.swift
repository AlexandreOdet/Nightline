//
//  BaseViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func getPurpleColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.purple)
  }
  
  func getPrimaryColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorPrimary)
  }

  func getAccentColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorAccent)
  }

  static func getWhiteColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.white)
  }

}
