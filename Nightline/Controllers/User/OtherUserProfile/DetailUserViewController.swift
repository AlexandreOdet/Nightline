//
//  DetailUserViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 08/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class DetailUserViewController: UIViewController {
    enum FriendStatus: String {
        case notFriend = "Ajouter"
        case pending = "Pending"
        case friend = "Friend"
        case unknow = " "

        var text: String {
            return self.rawValue
        }

        var image: UIImage {
            switch self {
            case .notFriend:
                return UIImage(named: "addFriend")!
            case .pending:
                return UIImage(named: "pending")!
            case .friend:
                return UIImage(named: "friend")!
            default:
                return UIImage()
            }
        }
    }
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var profilePict: UIImageView!
    @IBOutlet weak var friendshipView: UIView!
    @IBOutlet weak var friendshipBtn: UIButton!
    @IBOutlet weak var friendshipImg: UIImageView!
    @IBOutlet weak var friendshipLabel: UILabel!
    @IBOutlet weak var trophyView: UIView!
    @IBOutlet weak var trophyLabel: UILabel!

    var user : User!
    var friendship: FriendStatus! {
        didSet {
            friendshipImg.image = friendship.image
            friendshipLabel.text = friendship.text
        }
    }
    let invitManager = RAInvitations()
    let friendManager = RAFriends()


    override func viewDidLoad() {
        super.viewDidLoad()
        friendship = .unknow
        checkFriendshipStatus()
        setView()
    }

    func setView() {
        topView.layer.cornerRadius = 5
        friendshipView.layer.cornerRadius = 5
        trophyView.layer.cornerRadius = 5
        trophyLabel.text = "\(user.achievementPoints) points"
        pseudoLabel.text = user.nickname
        firstnameLabel.text = user.firstName
        lastnameLabel.text = user.lastName
        profilePict.translatesAutoresizingMaskIntoConstraints = false
        profilePict.roundImage(withBorder: true, borderColor: UIColor(hex: 0x0e1728), borderSize: 1.0)
        CloudinaryManager.shared.downloadProfilePicture(withUserId: String(user.id)) { (img) in
            DispatchQueue.main.async {
                self.profilePict.image = img
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    func checkFriendshipStatus() {
        firstly {
            friendManager.getUserFriendsList(userId: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                if (result.friends.filter {$0.id == self.user.id}).count > 0 {
                    self.friendship = .friend
                } else {
                    self.friendship = .notFriend
                }
        }
    }

    @IBAction func friendshipCliqued(_ sender: Any) {
        switch friendship {
        case .notFriend:
            addFriend()
        default:
            return
        }
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
