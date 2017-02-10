//
//  TabBarController.swift
//  Nightline
//
//  Created by Odet Alexandre on 06/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  static let notificationIdentifier = "LogoutNotification"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(callbackObserver), name: NSNotification.Name(rawValue: TabBarController.notificationIdentifier), object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create Tab one
    let tabOne = HomeViewController()
    let tabOneBarItem = UITabBarItem(title: "Map", image: R.image.placeholder(), selectedImage: R.image.placeholder_filled())
    
    tabOne.tabBarItem = tabOneBarItem
    
    
    // Create Tab two
    let tabTwo = UserProfileViewController()
    let tabTwoBarItem2 = UITabBarItem(title: "Profil", image: R.image.avatar(), selectedImage: R.image.user())
    
    tabTwo.tabBarItem = tabTwoBarItem2
    
    let tabThree = UserSettingsTableViewController()
    let tabBarThreeItem = UITabBarItem(title: "Settings", image: R.image.settings(), selectedImage: R.image.settings_filled())
    tabThree.tabBarItem = tabBarThreeItem
    
    self.tabBar.barTintColor = UIColor.orange
    self.viewControllers = [tabOne, tabTwo, tabThree]
  }
  
  // UITabBarControllerDelegate method
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    self.title = viewController.title
  }
  
  func callbackObserver() {
    self.selectedIndex = 0
    let notificationName = Notification.Name(HomeViewController.notificationIdentifier)
    NotificationCenter.default.post(name: notificationName, object: nil)
  }
  
}
