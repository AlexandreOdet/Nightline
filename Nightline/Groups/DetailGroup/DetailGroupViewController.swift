//
//  DetailGroupViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit
import SnapKit

class DetailGroupViewController: BaseViewController {
    let raGrp = RAGroup()
    let grpId = 0
    var grp: GroupResponse!
    let deepBlue = UIColor(hex: 0x0e1728)
    let lightBlue = UIColor(hex : 0x363D4C)
    var grpMembers = [User]()
    var grpMembersWithOwner = [User]()
    var owner: User?
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var membersCV: UICollectionView!
    @IBOutlet weak var editMembersBtn: UIButton!
    
    convenience init(grp: GroupResponse) {
        self.init()
        self.grp = grp
    }

    func setFakeUserList() {
        let user1 = User()
        user1.firstName = "Cedric"
        user1.lastName = "Moreaux"
        user1.id = 2
        let user2 = User()
        user2.firstName = "Florian"
        user2.lastName = "Seure"
        user2.id = 3
        let user3 = User()
        user3.firstName = "Maxime"
        user3.lastName = "Guittet"
        user3.id = 4
        let user4 = User()
        user4.firstName = "Diego"
        user4.lastName = "Moran"
        user4.id = 5
        let user5 = User()
        user5.firstName = "Leo"
        user5.lastName = "Bourrel"
        user5.id = 6
        grpMembers = [user1, user2, user3, user4, user5]
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(grp.id)
        print(grp.name)
        print("Owner : ", grp.owner.pseudo)
        print("Members :")
        grp.users?.forEach {print($0.nickname)}
//        setFakeUserList()
        setTheme()
        setData()
    }

    func setTheme() {
        mainView.backgroundColor = deepBlue
        membersCV.backgroundColor = deepBlue
        editMembersBtn.backgroundColor = lightBlue
        editMembersBtn.layer.cornerRadius = editMembersBtn.frame.height / 2
        editMembersBtn.clipsToBounds = true
    }

    func setData() {
        membersCV.delegate = self
        membersCV.dataSource = self
        membersCV.register(UINib(nibName: "GroupMemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "grpMember")
        nameLabel.text = grp.name
        grpMembers = grp.users ?? [User]()
        grpMembersWithOwner = grp.users ?? [User]()
        getOwnerData()
        membersCV.reloadData()
    }

    func getOwnerData() {
        let instance = RAUser()
        firstly {
            instance.getUserInfos(id: String(grp.owner.id))
            }.then { result -> Void in
                self.owner = result.user
                self.grpMembersWithOwner.append(result.user)
                DispatchQueue.main.async {
                    self.membersCV.reloadData()
                }
            }.catch { error -> Void in
                print("DetailGroupViewController - Error getting owner informations")
                print(error.localizedDescription)
        }
    }
    
    @IBAction func editMembers(_ sender: Any) {
        let nextVC = EditMembersViewController(usrList: grpMembers, grpId: grp.id)
        nextVC.modalPresentationStyle = .overCurrentContext
        present(nextVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grpMembersWithOwner.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = membersCV.dequeueReusableCell(withReuseIdentifier: "grpMember", for: indexPath) as! GroupMemberCollectionViewCell
        cell.backgroundColor = deepBlue
        cell.setData(usr: grpMembersWithOwner[indexPath.row])
        cell.setView()
        return cell
    }
}
