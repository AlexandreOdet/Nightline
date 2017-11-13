//
//  EditMembersViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 09/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditMembersViewController: UIViewController {
    public enum cv {
        case friends
        case members
    }

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

    func reloadCVs() {
        membersCV.reloadData()
        friendsCV.reloadData()
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
        guard let dragCoordinator = coordinator.session.localDragSession?.localContext as? MemberDragCoordinator else { return }
        let indexPath = coordinator.destinationIndexPath ?? IndexPath(item: collectionView.numberOfItems(inSection: 0), section: 0)
        dragCoordinator.calculateDestinationIndexPaths(from: indexPath, count: coordinator.items.count)
        dragCoordinator.destination = collectionView == membersCV ? .members : .friends
        moveMember(using: dragCoordinator, performingDropWith: coordinator)
//        guard let dragCoordinator = coordinator.session.localDragSession?.localContext as? MemberDragCoordinator else { return }
//        switch dragCoordinator.source {
//        case .friends:
//            memberList.insert(dragCoordinator.user, at: coordinator.destinationIndexPath?.row ?? 0)
//            if let index = friendList.index(where: { (usr) -> Bool in
//                return usr == dragCoordinator.user
//            }) {
//                friendList.remove(at: index)
//            }
//        case .members:
//            friendList.insert(dragCoordinator.user, at: coordinator.destinationIndexPath?.row ?? 0)
//            if let index = memberList.index(where: { (usr) -> Bool in
//                return usr == dragCoordinator.user
//            }) {
//                memberList.remove(at: index)
//            }
//        }
//        membersCV.reloadData()
//        friendsCV.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    func moveMember(using dragCoordinator: MemberDragCoordinator, performingDropWith dropCoordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPaths = dragCoordinator.destinationIndexPaths else { return }
        for (index, item) in dropCoordinator.items.enumerated() {
            let sourceIndexPath = dragCoordinator.sourceIndexPaths[index]
            let destinationIndexPath = destinationIndexPaths[index]
            if dragCoordinator.isReordering {
                let cv = dragCoordinator.source == .friends ? friendsCV : membersCV
                switch dragCoordinator.source {
                case .friends:
                    friendList.remove(at: friendList.index {$0 == dragCoordinator.user} ?? 0)
                case .members:
                    memberList.remove(at: memberList.index {$0 == dragCoordinator.user} ?? 0)
                }
                cv?.performBatchUpdates({
                    cv?.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                }) { _ in
                    self.reloadCVs()}
            } else {
                let cv = dragCoordinator.source == .friends ? membersCV : friendsCV
                cv?.performBatchUpdates({
                    switch dragCoordinator.destination {
                    case .members:
                        memberList.insert(dragCoordinator.user, at: destinationIndexPath.item)
                    case .friends:
                        friendList.insert(dragCoordinator.user, at: destinationIndexPath.item)
                    }
                    cv?.insertItems(at: [destinationIndexPath])
                }) { _ in
                    self.reloadCVs()}
            }
            dropCoordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}

extension EditMembersViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let memberDragCoordinator = MemberDragCoordinator(source: collectionView == friendsCV ? .friends : .members)
        switch collectionView {
        case friendsCV:
            memberDragCoordinator.user = friendList[indexPath.row]
        default:
            memberDragCoordinator.user = memberList[indexPath.row]
        }
        session.localContext = memberDragCoordinator
        return [memberDragCoordinator.dragItemForMemberAt(indexPath: indexPath)]
    }
}
