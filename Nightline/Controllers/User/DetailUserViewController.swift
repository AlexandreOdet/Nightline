//
//  DetailUserViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 28/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class DetailUserViewController: ProfileViewController {

    var user : User!
    var friendship = FriendStatus.notFriend
    let invitManager = RAInvitations()
    let friendManager = RAFriends()

    enum FriendStatus: String {
        case notFriend = ""
        case pending = "Pending"
        case friend = "Friend"

        var text: String {
            return self.rawValue
        }

        var image: UIImage {
            switch self {
            case .notFriend:
                return UIImage(named: "addFriend")!
            case .pending:
                return UIImage(named: "pending")!
            default:
                return UIImage(named: "friend")!
            }
        }
    }

    override func viewDidLoad() {
        self.isUser = true
        super.viewDidLoad()
        checkFriendshipStatus()
        setUpView()
    }

    func checkFriendshipStatus() {
        firstly {
            friendManager.getUserFriendsList(userId: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                result.friends.forEach({ (user) in
                    if user.id == self.user.id {
                        self.friendship = .friend
                    }
                })
        }
        firstly {
            invitManager.getUserInvitations(userID: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                result.invitations.forEach({ (inv) in

                })
        }
    }

    private func setUpView() {
        self.imgProfile.image = R.image.male()
        CloudinaryManager.shared.downloadProfilePicture(withUserId: String(user.id)) { (img) in
            DispatchQueue.main.async {
                self.imgProfile.image = img
            }
        }
        if  user.firstName != "", user.lastName != "" {
            self.nameLabel.text = user.firstName + " " + (user.lastName.first?.description)!
        } else if user.firstName != "" {
            self.nameLabel.text = user.firstName
        } else {
            self.nameLabel.text = ""
        }
        self.nicknameLabel.text = user.nickname 
        if UserManager.instance.getUserAge() == "" {
            self.birthdayLabel.text = ""
        } else {
            self.birthdayLabel.text = UserManager.instance.getUserAge() + " ans"
        }
        self.locationLabel.text = user.city
        self.descriptionLabel.text = ""
        self.friendsLabel.text = String(describing: user.friends.count)
        self.pictureLabel.text = ""
        self.trophyLabel.text = String(user.achievementPoints)
        self.pictureImage.image = self.friendship.image
        let friendTapAction = UITapGestureRecognizer(target: self, action: #selector(addFriendAction))
        self.pictureView.addGestureRecognizer(friendTapAction)
        self.pictureLabel.text = friendship.text
    }

    @objc func addFriendAction() {
        switch friendship {
        case .notFriend:
            addFriend()
        default:
            return
        }
        self.pictureLabel.text = friendship.text
        self.pictureImage.image = friendship.image
    }

    func addFriend() {
        friendship = .pending
        invitManager.inviteFriend(userId: String(UserManager.instance.retrieveUserId()),
                                  friendId: String(user.id)) { result in
                                    switch result {
                                    case .success:
                                        break
                                    default:
                                        self.friendship = .notFriend
                                    }
        }
    }
}
