
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
    
    if let profileImage = UIImage(data: UserManager.instance.getUserPicture()! as Data) {
      self.imgProfile.image = profileImage
    } else {
      self.imgProfile.image = R.image.male()
    }
    if  UserManager.instance.getUserFirstName() != "", UserManager.instance.getUserLastName() != ""{
      self.nameLabel.text = UserManager.instance.getUserFirstName() + " " + (UserManager.instance.getUserLastName().characters.first?.description)!
    } else {
      self.nameLabel.text = ""
    }
    self.nicknameLabel.text = UserManager.instance.getUserNickname()
    if UserManager.instance.getUserAge() == "" {
      self.birthdayLabel.text = ""
    } else {
      self.birthdayLabel.text = UserManager.instance.getUserAge() + " ans"
    }
    self.locationLabel.text = UserManager.instance.getUserCity()
    self.descriptionLabel.text = "Epitech 4th year student in China, Beijing"
    self.friendsLabel.text = "0"
    self.pictureLabel.text = "0"
    self.trophyLabel.text = UserManager.instance.getUserAchievementPoints()
    
    let friendsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserFriendsList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    self.friendsView.addGestureRecognizer(friendsGestureRecognizer)
    
    let mediaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserMediaList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    self.pictureView.addGestureRecognizer(mediaGestureRecognizer)
    
    let achievementsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserAchievementsList))
    achievementsGestureRecognizer.numberOfTapsRequired = 1
    self.trophyView.addGestureRecognizer(achievementsGestureRecognizer)
  }
  
  func showUserFriendsList() {
    let nextViewController = UserFriendsListTableViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func showUserMediaList() {
    let nextViewController = UserMediaTableViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func showUserAchievementsList() {
    let nextViewController = UserAchievementsListCollectionViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  
}
