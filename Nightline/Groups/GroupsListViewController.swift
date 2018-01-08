//
//  GroupsListViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 12/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit
import PromiseKit
import SnapKit
import SwiftSpinner

class GroupsListViewController: BaseViewController {

    let raUser = RAUser()
    let raGrp = RAGroup()
    let raInvit = RAInvitations()
    var grpList: [GroupPreview] = []
    var grpInvits = [GroupInvitation]()
    var image = UIImageView()
    let reuseId = "grpCell"
    let deepBlue = UIColor(hex: 0x0e1728)
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setTheme()
        getGroupInvits()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.edgesForExtendedLayout = []
        getGrpList()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

    func setTheme() {
        self.tableView.backgroundColor = deepBlue
        self.tableView.separatorColor = deepBlue
        self.view.backgroundColor = deepBlue
    }

    func setNavBar() {
        navigationController?.title = "Groupes"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGrp))
    }

    @objc func addGrp() {
        print("Create group triggered")
        let addGrpVc = AddGroupViewController()
        addGrpVc.modalPresentationStyle = .overCurrentContext
        addGrpVc.reloadTVData = getGrpList
        present(addGrpVc, animated: true, completion: nil)
    }

    func setBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    func getGroupInvits() {
        firstly {
            raInvit.getUserGroupsInvitations(userID: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                self.grpInvits = result.list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }

    func getGrpList() {
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        setNavBar()
        firstly {
            raUser.getUserGroupList(id: String(UserManager.instance.retrieveUserId()))
            }.then { result -> Void in
                self.grpList = result.groups
                self.tableView.reloadData()
                _ = self.grpList.map {print("grp: " + String($0.id!) + " " + $0.name)}
            }.catch { error -> Void in
                print("Error : \(error)")
        }
    }

    func deleteGrp(grp: GroupPreview) {
        print(String(grp.id))
        raGrp.deleteGroup(groupId: String(grp.id)) { result in
            switch result {
            case .success():
                self.getGrpList()
            case .failure(let error):
                let alert = UIAlertController(title: "Erreur", message: "La supression du groupe \"\(grp.name!)\" à échouée", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                print(error)
            }
        }
    }

    func confirmDelete(grp: GroupPreview) {
        let alert = UIAlertController(title: "Supression", message: "Etes vous sur de vouloir supprimer le groupe \"\(grp.name!)\"?", preferredStyle: .actionSheet)
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAct = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteGrp(grp: grp)
        }
        alert.addAction(cancelAct)
        alert.addAction(deleteAct)
        present(alert, animated: true, completion: nil)
    }
}

extension GroupsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return grpInvits.count > 0 ? 2 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if grpInvits.count == 0 || section == 1 {
            return grpList.count + 1
        } else {
            return grpInvits.count
        }
        //        return grpList.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if grpInvits.count == 0 || indexPath.section == 1 {
            return makeGroupCell(indexPath: indexPath)
        } else {
            return makeInvitCell(indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = deepBlue
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        titleLabel.textColor = .orange
        if grpInvits.count == 0 || section == 1 {
            titleLabel.text = "Vos groupes:"
        } else {
            titleLabel.text = "Invitations en attente:"
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if grpInvits.count == 0 || indexPath.section == 1 {
            let delete: UITableViewRowAction = UITableViewRowAction(style: .default , title: "Delete") { (action, indexPath) in
                self.confirmDelete(grp: self.grpList[indexPath.row])
            }
            delete.backgroundColor = deepBlue
            return [delete]
        } else {
            let accept: UITableViewRowAction = UITableViewRowAction(style: .default, title: "Accept") { (action, indexPath) in
                self.acceptInvit(id: self.grpInvits[indexPath.row].id)
            }
            accept.backgroundColor = deepBlue

            let decline: UITableViewRowAction = UITableViewRowAction(style: .default, title: "Refuse") { (action, indexPath) in
                self.declineInvit(id: self.grpInvits[indexPath.row].id)
            }
            decline.backgroundColor = deepBlue

            return [accept, decline]
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if grpInvits.count == 0 || indexPath.section == 1 {
            let grpId = grpList[indexPath.row].id
            SwiftSpinner.show("Chargement des détails du groupe")
            firstly {
                raGrp.getGroupInformations(groupId: grpId ?? 0)
                }.then { group -> Void in
                    let nextVC = DetailGroupViewController(grp: group.group)
                    self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
                    SwiftSpinner.hide()
                    if let nav = self.navigationController {
                        nav.pushViewController(nextVC, animated: true)
                    }
                }.catch { _ -> Void in
                    SwiftSpinner.hide() {
                        self.showErrorLoadingGrpDetails()
                    }
            }
        }
    }

    func makeInvitCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = deepBlue
        let bg = UIView()
        cell.addSubview(bg)
        bg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(4)
        }
        bg.layer.cornerRadius = 5
        bg.backgroundColor = UIColor(hex : 0x363D4C)
        bg.clipsToBounds = true

        let nameLabel = UILabel()
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell).inset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(25)
        }
        nameLabel.text = grpInvits[indexPath.row].from.name
        nameLabel.textColor = UIColor.orange

        let descTextView = UITextView()
        cell.addSubview(descTextView)
        descTextView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalTo(cell).inset(5)
            make.height.equalTo(55)
        }
        descTextView.isEditable = false
        descTextView.textColor = UIColor.orange
        descTextView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        descTextView.text = grpInvits[indexPath.row].from.description

        return cell
    }

    func makeGroupCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = deepBlue
        if indexPath.row < grpList.count {
            let bg = UIView()
            cell.addSubview(bg)
            bg.snp.makeConstraints { (make) in
                make.edges.equalToSuperview().inset(4)
            }
            bg.layer.cornerRadius = 5
            bg.backgroundColor = UIColor(hex : 0x363D4C)
            bg.clipsToBounds = true

            let nameLabel = UILabel()
            cell.addSubview(nameLabel)
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(cell).inset(5)
                make.left.right.equalToSuperview().inset(10)
                make.height.equalTo(25)
            }
            nameLabel.text = grpList[indexPath.row].name
            nameLabel.textColor = UIColor.orange

            let descTextView = UITextView()
            cell.addSubview(descTextView)
            descTextView.snp.makeConstraints { (make) in
                make.right.left.bottom.equalTo(cell).inset(5)
                make.height.equalTo(55)
            }
            descTextView.isEditable = false
            descTextView.textColor = UIColor.orange
            descTextView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
            descTextView.text = grpList[indexPath.row].description
        } else if grpList.count == 0 {
            let noGrpLabel = UILabel()
            cell.addSubview(noGrpLabel)
            noGrpLabel.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            noGrpLabel.text = "Aucun groupe"
            noGrpLabel.textAlignment = .center
            noGrpLabel.textColor = .orange
        }
        return cell
    }

    func acceptInvit(id: Int) {
        print("Accept invit nbr : \(id)")
        raInvit.acceptGroupInvitation(invitationID: String(id)) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func declineInvit(id: Int) {
        print("Decline invit nbr : \(id)")
        raInvit.declineGroupInvitation(invitationID: String(id)) { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func showErrorLoadingGrpDetails() {
        let alert = UIAlertController(title: "Erreur", message: "Le chargement des details du groupe a échoué", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
