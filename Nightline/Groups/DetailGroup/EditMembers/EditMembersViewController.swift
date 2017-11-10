//
//  EditMembersViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 09/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditMembersViewController: UIViewController {
    @IBOutlet weak var friendsCV: UICollectionView!
    @IBOutlet weak var membersCV: UICollectionView!
    @IBOutlet weak var friendBackground: UIView!
    @IBOutlet weak var memberBackground: UIView!
    @IBOutlet weak var doneBtnBackground: UIView!
    @IBOutlet weak var doneBtn: UIButton!

    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    var friendList = [User]()
    var memberList = [User]()
    
    convenience init(usrList: [User]) {
        self.init()
        self.memberList = usrList
        let user = User()
        user.firstName = "Alexandre"
        user.lastName = "Odet"
        self.friendList = [user]
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setData()
    }
    
    func setData() {
        membersCV.delegate = self
        membersCV.dataSource = self
        membersCV.dragDelegate = self
        membersCV.dropDelegate = self
        membersCV.dragInteractionEnabled = true
        membersCV.register(UINib(nibName: "GroupMemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "grpMember")
        friendsCV.delegate = self
        friendsCV.dataSource = self
        friendsCV.dragDelegate = self
        friendsCV.dropDelegate = self
        friendsCV.dragInteractionEnabled = true
        friendsCV.register(UINib(nibName: "GroupMemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "grpMember")
    }
    
    func setTheme() {
        view.backgroundColor = .clear
        friendBackground.layer.cornerRadius = 10
        friendBackground.clipsToBounds = true
        memberBackground.layer.cornerRadius = 10
        memberBackground.clipsToBounds = true
        doneBtnBackground.layer.cornerRadius = 10
        doneBtnBackground.clipsToBounds = true
        friendsCV.backgroundColor = friendBackground.backgroundColor
        membersCV.backgroundColor = friendBackground.backgroundColor
        doneBtn.backgroundColor = friendBackground.backgroundColor
    }

    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension EditMembersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case friendsCV:
            return friendList.count
        default:
            return memberList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var list = [User]()
        switch collectionView {
        case friendsCV:
            list = friendList
        default:
            list = memberList
        }
        let cell = membersCV.dequeueReusableCell(withReuseIdentifier: "grpMember", for: indexPath) as! GroupMemberCollectionViewCell
        cell.backgroundColor = friendBackground.backgroundColor
        cell.setData(usr: list[indexPath.row])
        cell.setView()
        return cell
    }


}

extension EditMembersViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let indexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        coordinator.session.loadObjects(ofClass: NSString.self) { (string) in

        }

    }
}

extension EditMembersViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        var list = [User]()
        var e = ""
        switch collectionView {
        case friendsCV:
            list = friendList
            e = "f"
        default:
            list = memberList
            e = "m"
        }
        let t = e + String(indexPath.row)
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: t as NSString))
        return [dragItem]
    }
}
