//
//  UserProfileViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 02/12/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit

class UserProfileViewController: BaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var friendsView: UIView!
    @IBOutlet weak var friendsIcon: UIImageView!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var trophyView: UIView!
    @IBOutlet weak var trophyIcon: UIImageView!
    @IBOutlet weak var trophyLabel: UILabel!
    @IBOutlet weak var mediasCV: UICollectionView!
    @IBOutlet weak var mediasView: UIView!
    @IBOutlet weak var achievementsView: UIView!
    @IBOutlet weak var achievementsCV: UICollectionView!

    let deepBlue = UIColor(hex: 0x0e1728)
    let friendsInstance = RAFriends()
    let userInstance = RAUser()
    var friendList: FriendsList?
    var photos = [UIImage]()
    var successArray = [Success]()
    
    func setTopView() {
        topView.layer.cornerRadius = 5
        topView.clipsToBounds = true
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.roundImage(withBorder: true, borderColor: UIColor(hex: 0x0e1728), borderSize: 1.0)
    }

    func getSuccessData() {
        firstly {
            userInstance.getUserAchievementsList(id: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                self.successArray = result.success
                DispatchQueue.main.async {
                self.achievementsCV.reloadData()
                }
            }.catch { (error) in
                print("Get success data - error")
        }
    }

    func fillTopView() {
        picture.image = UserManager.instance.getUserPicture(callback: { (img) in
            DispatchQueue.main.async {
                self.picture.image = img
            }
        })
        firstnameLabel.text = UserManager.instance.getUserFirstName()
        nameLabel.text = UserManager.instance.getUserLastName()
        pseudoLabel.text = UserManager.instance.getUserNickname()
        if UserManager.instance.getUserAge().isEmpty {
            ageLabel.text = ""
        } else {
            ageLabel.text = UserManager.instance.getUserAge() + " ans"
        }
        cityLabel.text = UserManager.instance.getUserNumber()
    }

    func setFriendsView() {
        friendsView.clipsToBounds = true
        friendsView.layer.cornerRadius = 5
        friendsIcon.image = UIImage(named: "friends")?.withRenderingMode(.alwaysTemplate)
        friendsIcon.tintColor = deepBlue
        friendsLabel.text = "0 ami"
        getFriends()
        friendsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(friendViewClicked)))
    }

    func setTrophyView() {
        trophyView.clipsToBounds = true
        trophyView.layer.cornerRadius = 5
        trophyIcon.image = UIImage(named: "trophy")?.withRenderingMode(.alwaysTemplate)
        trophyIcon.tintColor = deepBlue
        trophyLabel.text = "\(UserManager.instance.getUserAchievementPoints()) points"
    }

    func setMediasView() {
        photos = MediaManager.instance.getAllImages()
        mediasCV.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        mediasView.layer.cornerRadius = 5
        mediasCV.backgroundColor = .clear
    }

    func setAchievementsView() {
        achievementsCV.register(UINib(nibName: "AchievementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "achievementCell")
        getSuccessData()
    }

    func getFriends() {
        firstly {
            friendsInstance.getUserFriendsList(userId: String(UserManager.instance.retrieveUserId()))
            }.then { [weak self] result -> Void in
                guard let strongSelf = self else { return }
                strongSelf.friendList = result
                DispatchQueue.main.async {
                    if let list = strongSelf.friendList {
                        if list.friends.count > 1 {
                            strongSelf.friendsLabel.text = "\(list.friends.count) amis"
                        } else {
                            strongSelf.friendsLabel.text = "\(list.friends.count) ami"
                        }
                    }
                }
            }.catch { error -> Void in
                // Handle error?
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTopView()
        fillTopView()
        setFriendsView()
        setTrophyView()
        setMediasView()
        setAchievementsView()
        let lineNbr = CGFloat(photos.count / 3 + 1)
        //let sizeCell = (mediasCV.frame.width / 3) - 8
        //let viewHeight = lineNbr * (sizeCell + 8)
        mediasView.frame.size.height = 700
        print(lineNbr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func friendViewClicked() {
        let nv = UserFriendsListTableViewController()
        self.navigationController?.pushViewController(nv, animated: true)
    }
}

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mediasCV:
            return photos.count
        default:
            return successArray.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mediasCV:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
                cell.setImg(img: photos[indexPath.row])
                return cell
            } else {
                return UICollectionViewCell()
            }
        case achievementsCV:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievementCell", for: indexPath) as? AchievementCollectionViewCell {
                cell.setCell(withSuccess: successArray[indexPath.row])
                return cell
            } else {
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mediasCV:
            let size = (collectionView.frame.width / 3) - 8
            return CGSize(width: size, height: size)
        default:
            return CGSize(width: 180, height: 90)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case mediasCV:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
