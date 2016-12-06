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

class HomeViewController: BaseViewController {
  
  let logoutButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.addSubview(logoutButton)
      logoutButton.snp.makeConstraints { (make) -> Void in
        make.center.equalTo(self.view)
        make.size.equalTo(75)
      }
      logoutButton.translatesAutoresizingMaskIntoConstraints = false
      logoutButton.addTarget(self, action: #selector(LogoutAction), for: .touchUpInside)
      logoutButton.backgroundColor = UIColor.white
      
      let rightBarButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(goToUserProfileViewController))
      self.navigationItem.rightBarButtonItem = rightBarButton
    }
  }
  
  func LogoutAction() {
    //self.view.window?.rootViewController?.dismiss(animated:true, completion:nil)
  }
  
  func goToUserProfileViewController() {
    self.navigationController?.pushViewController(UserProfileViewController(), animated: true)
  }
  
}
