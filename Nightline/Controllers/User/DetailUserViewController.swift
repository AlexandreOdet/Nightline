//
//  DetailUserViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 28/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class DetailUserViewController: ProfileViewController {

    var user : User!

    override func viewDidLoad() {
        self.isUser = true
        super.viewDidLoad()
//        if self.user == nil {
//            print("Error when initializing userDetailviewController, user was nil")
//            dismiss(animated: true, completion: nil)
//        }

        setUpView()
    }

    private func setUpView() {
        self.imgProfile.image = R.image.male()
        if  user.firstName != "", user.lastName != "" {
            self.nameLabel.text = user.firstName + " " + (user.lastName.characters.first?.description)!
        } else if user.firstName != "" {
            self.nameLabel.text = user.firstName
        } else {
            self.nameLabel.text = ""
        }
        self.nicknameLabel.text = user.nickname 
        if UserManager.instance.getUserAge() == "" {
            self.birthdayLabel.text = ""
        } else {
            self.birthdayLabel.text = user.age + " ans"
        }
        self.locationLabel.text = user.city
        self.descriptionLabel.text = "Epitech 4th year student in China, Beijing"
        self.friendsLabel.text = String(describing: user.friends.count)
        self.pictureLabel.text = "" //String(MediaManager.instance.getAllImages().count)
        self.trophyLabel.text = UserManager.instance.getUserAchievementPoints()

//        let friendsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserFriendsList))
//        friendsGestureRecognizer.numberOfTapsRequired = 1
//        self.friendsView.addGestureRecognizer(friendsGestureRecognizer)

//        let mediaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserMediaList))
//        friendsGestureRecognizer.numberOfTapsRequired = 1
//        self.pictureView.addGestureRecognizer(mediaGestureRecognizer)

//        let achievementsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showUserAchievementsList))
//        achievementsGestureRecognizer.numberOfTapsRequired = 1
//        self.trophyView.addGestureRecognizer(achievementsGestureRecognizer)
    }

//    func showUserFriendsList() {
//        let vc = SearchUserViewController()
//        tabBarController?.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func showUserMediaList() {
//        let images = MediaManager.instance.getAllImages()
//        if images.count > 0 {
//            let lightboxImages = images.map {LightboxImage(image: $0)}
//            let showMediaController = LightboxController(images: lightboxImages)
//            showMediaController.dynamicBackground = true
//            present(showMediaController, animated: true, completion: nil)
//        }
//    }
//    
//    func showUserAchievementsList() {
//        let nextViewController = UserAchievementsListCollectionViewController()
//        tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)
//    }
}
