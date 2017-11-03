
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
import Lightbox

final class UserProfileViewController: ProfileViewController {
  
  override func viewDidLoad() {
    isUser = true
    super.viewDidLoad()
    setUpView()
  }
  
  private func setUpView() {
    if let imgdt = UserManager.instance.getUserPicture(), let profileImage = UIImage(data: (imgdt as Data)) {
      imgProfile.image = profileImage
    } else {
      imgProfile.image = R.image.male()
    }
    if  !UserManager.instance.getUserFirstName().isEmpty, !UserManager.instance.getUserLastName().isEmpty {
      nameLabel.text = UserManager.instance.getUserFirstName() + " " + (UserManager.instance.getUserLastName().characters.first?.description)!
    } else {
      nameLabel.text = ""
    }
    nicknameLabel.text = UserManager.instance.getUserNickname()
    if UserManager.instance.getUserAge().isEmpty {
      birthdayLabel.text = ""
    } else {
      birthdayLabel.text = UserManager.instance.getUserAge() + " ans"
    }
    locationLabel.text = UserManager.instance.getUserCity()
    descriptionLabel.text = "Epitech 4th year student in China, Beijing"
    friendsLabel.text = "0"
    pictureLabel.text = String(MediaManager.instance.getAllImages().count)
    trophyLabel.text = UserManager.instance.getUserAchievementPoints()
    
    let friendsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserFriendsList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    friendsView.addGestureRecognizer(friendsGestureRecognizer)
    
    let mediaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserMediaList))
    friendsGestureRecognizer.numberOfTapsRequired = 1
    pictureView.addGestureRecognizer(mediaGestureRecognizer)
    
    let achievementsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserAchievementsList))
    achievementsGestureRecognizer.numberOfTapsRequired = 1
    trophyView.addGestureRecognizer(achievementsGestureRecognizer)
  }
  
  @objc func showUserFriendsList() {
    let vc = UserFriendsListTableViewController()
    tabBarController?.navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func showUserMediaList() {
    let images = MediaManager.instance.getAllImages()
    if images.count > 0 {
      let lightboxImages = images.map {LightboxImage(image: $0)}
      let showMediaController = LightboxController(images: lightboxImages)
      showMediaController.dynamicBackground = true
      present(showMediaController, animated: true, completion: nil)
    }
  }
  
  @objc func showUserAchievementsList() {
    let nextViewController = UserAchievementsListCollectionViewController()
    tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
  }
}
