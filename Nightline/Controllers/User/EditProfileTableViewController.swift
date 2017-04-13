//
//  EditProfileTableViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 03/04/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

class EditProfileTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var sectionsArray : [[String]] = [["Photo"], ["Prénom", "Nom", "Pseudo"], ["Age", "Ville"]]
  var tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Edition du profil"
    //addTableView()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView = UITableView(frame: self.view.frame, style: .grouped)
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) -> Void in
      make.left.right.bottom.equalTo(self.view)
      make.top.equalTo(self.view)
      //.offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
    }
    tableView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  /*------------- UITableView Functions -------------*/
  
  //  func numberOfSections(in tableView: UITableView) -> Int {
  //    return 4
  //  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionsArray[section].count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = DoubleLabelTableViewCell()
    if (indexPath.section == 0) {
      let pictureCell = ProfilePictCell()
      return pictureCell
    } else if (indexPath.section == 1) {
      switch indexPath.row {
      case 0:
        cell.labelLeft.text = UserManager.instance.getUserFirstName()
      case 1:
        cell.labelLeft.text = UserManager.instance.getUserLastName()
      default:
        cell.labelLeft.text = UserManager.instance.getUserNickname()
      }
    } else {
      switch indexPath.row {
      case 0:
        cell.labelLeft.text = UserManager.instance.getUserAge()
      default:
        cell.labelLeft.text = UserManager.instance.getUserCity()
      }
    }
    cell.labelRight.text = self.sectionsArray[indexPath.section][indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (indexPath.section == 0) {
      
    } else if (indexPath.section == 1) {
      if (indexPath.row == 0) {
        let nextViewController = EditFirstNameViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      } else if (indexPath.row == 1) {
        let nextViewController = EditLastNameViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      } else if (indexPath.row == 2) {
        let nextViewController = EditNickNameViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      }
    } else if (indexPath.section == 2) {
      if (indexPath.row == 0) {
        let nextViewController = EditAgeViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      } else if (indexPath.row == 1) {
        let nextViewController = EditCityViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 100
    }
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if (section == 0) {
      return "Photo"
    } else if (section == 1) {
      return "Noms"
    } else {
      return "Autres informations"
    }
  }
  
  /*------------- UITableView Actions -------------*/
  
  /*
   performLogoutAction() function.
   This function logout the user from the app.
   @param None
   @return None
   */
  
  func performLogoutAction() {
    Utils.Network.logOutUser()
    let notificationName = Notification.Name(TabBarController.notificationIdentifier)
    NotificationCenter.default.post(name: notificationName, object: nil)
  }
  
  /*
   goToEditProfilViewController() function.
   This function goes to user profile on editing mode.
   @param None
   @return None
   */
  
  func goToEditProfilViewController() {
    let nextViewController = EditProfileTableViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
}
