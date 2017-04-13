
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
    self.nameLabel.text = UserManager.instance.getUserFirstName() + " " + (UserManager.instance.getUserLastName().characters.first?.description)!
    self.imgProfile.image = UIImage(data: UserManager.instance.getUserPicture()! as Data)
    self.nicknameLabel.text = UserManager.instance.getUserNickname()
    self.birthdayLabel.text = UserManager.instance.getUserAge() + " ans"
    self.locationLabel.text = UserManager.instance.getUserCity()
    self.descriptionLabel.text = "Epitech 4th year student in China, Beijing"
    self.friendsLabel.text = "220"
    self.pictureLabel.text = "55"
    self.trophyLabel.text = "520"
    
    let friendsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserFriendsList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    self.friendsView.addGestureRecognizer(friendsGestureRecognizer)
    
    let achievementsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserAchievementsList))
    achievementsGestureRecognizer.numberOfTapsRequired = 1
    self.trophyView.addGestureRecognizer(achievementsGestureRecognizer)
  }
  
  func showUserFriendsList() {
    let nextViewController = UserFriendsListTableViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func showUserAchievementsList() {
    let nextViewController = UserAchievementsListCollectionViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
}
