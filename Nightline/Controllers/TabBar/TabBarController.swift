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

/*
 Controllers: TabBarController.
 This controller initialize the tab bar.
 */

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  public class var notificationIdentifier: String { return "LogoutNotification" }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(callbackObserver), name: NSNotification.Name(rawValue: TabBarController.notificationIdentifier), object: nil)
    tabBar.tintColor = UIColor.black
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create Tab one
    let tabOne = MainViewController()
    let tabOneBarItem = UITabBarItem(title: "Map", image: R.image.placeholder(), selectedImage: R.image.placeholder_filled())
    
    tabOne.tabBarItem = tabOneBarItem
    
    
    // Create Tab two
    let tabTwo = UserProfileViewController()
    let tabTwoBarItem2 = UITabBarItem(title: R.string.localizable.profile(), image: R.image.avatar(), selectedImage: R.image.user())
    
    tabTwo.tabBarItem = tabTwoBarItem2

    // Create Tab Three
    let tabThree = GroupsListViewController()
    let tabBarThreeItem = UITabBarItem(title: "Groups", image: R.image.settings(), selectedImage: R.image.settings_filled())
    tabThree.tabBarItem = tabBarThreeItem

    // Create Tab Four
    let tabFour = UserSettingsTableViewController()
    let tabBarFourItem = UITabBarItem(title: R.string.localizable.settings(), image: R.image.settings(), selectedImage: R.image.settings_filled())
    tabFour.tabBarItem = tabBarFourItem
    
    tabBar.barTintColor = UIColor.orange
    viewControllers = [tabOne, tabTwo, tabThree, tabFour]
  }
  
  // UITabBarControllerDelegate method
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    self.title = viewController.title
  }
  
  /*
   callbackObserver() function.
   When Observer sets in viewDidLoad function receive the notification "TabBarController.notificationIdentifier" this function is called.
   @param None
   @return None
   */
  
  @objc func callbackObserver() {
    selectedIndex = 0
    let notificationName = Notification.Name(MainViewController.notificationIdentifier)
    NotificationCenter.default.post(name: notificationName, object: nil)
  }
  
}
