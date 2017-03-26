
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
import Rswift

final class UserProfileViewController: ProfileViewController {
  
  override func viewDidLoad() {
    self.isUser = true
    super.viewDidLoad()
    setUpView()
  }
  
  private func setUpView() {
    self.nameLabel.text = "Cédric M"
    self.imgProfile.image = R.image.profile()
    self.nicknameLabel.text = "Xploit"
    self.birthdayLabel.text = "22 ans"
    self.locationLabel.text = "Pékin"
    self.descriptionLabel.text = "Epitech 4th year student in China, Beijing"
    self.friendsLabel.text = "220"
    self.pictureLabel.text = "55"
    self.trophyLabel.text = "520"
    
    let friendsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserFriendsList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    
    self.friendsView.addGestureRecognizer(friendsGestureRecognizer)
  }
  
  func showUserFriendsList() {
    let nextViewController = UserFriendsListTableViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
}
