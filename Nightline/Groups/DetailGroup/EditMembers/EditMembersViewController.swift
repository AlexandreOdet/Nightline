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
    var blurEffectView: UIVisualEffectView?
    var cvs = Dictionary<cv,UICollectionView>()
    var lists: Dictionary<cv, [User]> = [.members: [User](), .friends: [User]()]
    
    convenience init(usrList: [User]) {
        self.init()
        self.lists[.members]! = usrList
        let user = User()
        user.firstName = "Alexandre"
        user.lastName = "Odet"
        user.id = 1
        self.lists[.friends] = [user]
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
        setBlur()
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
        cvs = [cv.members: self.membersCV, cv.friends: self.friendsCV]
    }
    
    func setTheme() {
        view.backgroundColor = .clear
        friendBackground.backgroundColor = deepBlue
        friendBackground.layer.cornerRadius = 10
        friendBackground.clipsToBounds = true
        memberBackground.backgroundColor = friendBackground.backgroundColor
        memberBackground.layer.cornerRadius = 10
        memberBackground.clipsToBounds = true
        doneBtnBackground.backgroundColor = lightBlue
        doneBtnBackground.layer.cornerRadius = 10
        doneBtnBackground.clipsToBounds = true
        friendsCV.backgroundColor = friendBackground.backgroundColor
        membersCV.backgroundColor = friendBackground.backgroundColor
        doneBtn.backgroundColor = lightBlue
    }

    func reloadCVs() {
        membersCV.reloadData()
        friendsCV.reloadData()
    }

    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func setBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView!.alpha = 0.3
        view.addSubview(blurEffectView!)
        view.sendSubview(toBack: blurEffectView!)
    }
}

extension EditMembersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case friendsCV:
            return lists[.friends]!.count
        default:
            return lists[.members]!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grpMember", for: indexPath) as! GroupMemberCollectionViewCell
        cell.backgroundColor = friendBackground.backgroundColor
        cell.setData(usr: lists[cvs.filter {$0.value == collectionView}.first!.key]![indexPath.row])
        cell.setView()
        return cell
    }
}

extension EditMembersViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let memberDragCoordinator = MemberDragCoordinator(source: cvs.filter {$0.value == collectionView}.first!.key)
        switch collectionView {
        case self.friendsCV:
            memberDragCoordinator.users.append(lists[.friends]![indexPath.row])
        default:
            memberDragCoordinator.users.append(lists[.members]![indexPath.row])
        }
        session.localContext = memberDragCoordinator
        return [memberDragCoordinator.dragItemForMemberAt(indexPath: indexPath)]
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        guard let dragCoordinator = session.localContext as? MemberDragCoordinator,
            dragCoordinator.source == (cvs.filter {$0.value == collectionView}.first!.key) else { return [] }
        return [dragCoordinator.dragItemForMemberAt(indexPath: indexPath)]
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        guard let dragCoordinator = session.localContext as? MemberDragCoordinator,
            dragCoordinator.source == (cvs.filter {$0.value == collectionView}.first!.key),
            dragCoordinator.dragCompleted == true,
            dragCoordinator.isReordering == false else { return }
    }
}

extension EditMembersViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        guard let _ = session.localDragSession?.localContext as? MemberDragCoordinator else { return false }
        return true
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard let _ = session.localDragSession?.localContext as? MemberDragCoordinator else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let dragCoordinator = coordinator.session.localDragSession?.localContext as? MemberDragCoordinator else { return }
        let indexPath = coordinator.destinationIndexPath ?? IndexPath(item: collectionView.numberOfItems(inSection: 0), section: 0)
        dragCoordinator.calculateDestinationIndexPaths(from: indexPath, count: coordinator.items.count)
        dragCoordinator.destination = cvs.filter {$0.value == collectionView}.first!.key
        moveMember(using: dragCoordinator, performingDropWith: coordinator)
    }

    func moveMember(using dragCoordinator: MemberDragCoordinator, performingDropWith dropCoordinator: UICollectionViewDropCoordinator) {
        guard let _ = dragCoordinator.destinationIndexPaths else { return }
        for user in dragCoordinator.users {
            lists[dragCoordinator.destination]!.append(user)
            let tmp = lists[dragCoordinator.source]!.index(where: {user.id == $0.id})
            lists[dragCoordinator.source]!.remove(at:tmp!)
        }
        self.reloadCVs()
    }
}
