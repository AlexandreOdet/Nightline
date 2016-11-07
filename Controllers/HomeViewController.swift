//
//  MainViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {

  let logoutButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let homeNavCtrl = UINavigationController()
    homeNavCtrl.viewControllers = [self]
    
    self.view.addSubview(logoutButton)
    logoutButton.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(75)
    }
    logoutButton.translatesAutoresizingMaskIntoConstraints = false
    logoutButton.addTarget(self, action: #selector(performLogoutAction), for: .touchUpInside)
    logoutButton.backgroundColor = UIColor.white
  }

  func LogoutAction() {
    //self.view.window?.rootViewController?.dismiss(animated:true, completion:nil)
  }
  
}
