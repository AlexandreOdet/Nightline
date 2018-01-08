//
//  UserSettingsTableViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/01/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift
import FBSDKLoginKit
import Stripe
import PromiseKit

/*
 Controllers: UserSettingsTableViewController
 This controller shows a UITableView containing all settings of the app.
 */

final class UserSettingsTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let reuseIdentifier = "SettingsCell"
    var tableView = UITableView()
    let infosArray = [R.string.localizable.thanks(), R.string.localizable.faq(), R.string.localizable.build()]
    let sectionArray = ["Profil", "Paiement", "Préférences", "Informations", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.settings()
        addTableView()
        tableView.backgroundColor = UIColor(hex: 0x0e1728)
        self.tableView.separatorColor = UIColor(hex: 0x0e1728)
    }
    
    /*
     addTableView() function.
     This function adds the UITableView and sets the constraints into the view.
     @param None.
     @return None.
     */
    
    private func addTableView() {
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /*------------- UITableView Functions -------------*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case SettingsCell.Profile.rawValue:
            count = 1
        case SettingsCell.Preference.rawValue:
            count = 2
        case SettingsCell.Info.rawValue:
            count = 3
        case SettingsCell.Logout.rawValue:
            return 1
        case SettingsCell.Payment.rawValue:
            return 1
        default:
            count = 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == SettingsCell.Profile.rawValue {
            let profileCell = UserProfileCell()
            profileCell.labelName.text = UserManager.instance.getUserNickname()
            profileCell.isUserInteractionEnabled = true
            profileCell.backgroundColor = UIColor(hex : 0x363D4C)
            profileCell.labelName.textColor = UIColor(hex: 0xE88B26)
            profileCell.labelEmail.textColor = UIColor(hex: 0xFFAF57)
            return profileCell
        } else {
            if indexPath.section == SettingsCell.Preference.rawValue {
                cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
                cell.textLabel?.text = (indexPath.row == 0) ? R.string.localizable.etabl() : R.string.localizable.drinks()
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.section == SettingsCell.Info.rawValue {
                cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
                cell.textLabel?.text = infosArray[indexPath.row]
                if indexPath.row == 2 {
                    cell = UITableViewCell(style: .value1, reuseIdentifier: self.reuseIdentifier)
                    cell.textLabel?.text = infosArray[indexPath.row]
                    cell.detailTextLabel?.text = Plist.Info.getBuildVersion()
                }
                cell.isUserInteractionEnabled = false
            } else if indexPath.section == SettingsCell.Payment.rawValue {
                cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
                cell.textLabel?.text = "Ajouter une carte"
            } else {
                cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
                cell.textLabel?.text = R.string.localizable.logout()
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = .red
            }
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(hex : 0x363D4C)
        cell.textLabel?.textColor = UIColor(hex: 0xE88B26)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SettingsCell.Preference.rawValue {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.onClick()
            if indexPath.row == 0 {
                let nextViewController = EtablishmentTableViewController()
                self.navigationController?.pushViewController(nextViewController, animated: true)
            } else {
                let nextViewController = ConsommationTableViewController()
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        } else if indexPath.section == SettingsCell.Logout.rawValue {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.onClick()
            self.performLogoutAction()
        } else if indexPath.section == SettingsCell.Profile.rawValue {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.onClick()
            self.goToEditProfilViewController()
        } else if indexPath.section == SettingsCell.Payment.rawValue {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.onClick()
            let nextVC = STPAddCardViewController()
            nextVC.delegate = self
            self.transitionDirection(from: .right)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == SettingsCell.Profile.rawValue {
            return 90
        }
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor(hex: 0xE88B26)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    
    /*------------- UITableView Actions -------------*/
    
    /*
     performLogoutAction() function.
     This function logout the user from the app.
     @param None
     @return None
     */
    
    func performLogoutAction() {
        Utils.Network.logOutUser()
        let notificationName = Notification.Name(TabBarController.notificationIdentifier)
        NotificationCenter.default.post(name: notificationName, object: nil)
        if FBSDKAccessToken.current() != nil {
            FBSDKLoginManager().logOut()
        }
    }
    
    /*
     goToEditProfilViewController() function.
     This function goes to user profile on editing mode.
     @param None
     @return None
     */
    
    func goToEditProfilViewController() {
        let nextViewController = EditProfileTableViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension UserSettingsTableViewController: STPAddCardViewControllerDelegate {
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
      print("tokenID = \(token.tokenId), stripeID = \(token.stripeID)")
        let paymentAPI = RAPayment()
        paymentAPI.sendCardInfos(creditCardToken: token.tokenId, user: UserManager.instance.networkUser) { ret in
            switch ret {
            case .error(let e):
                self.presentErrorAlert(e: e)
            case .success():
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func presentErrorAlert(e: Error?) {
        var msg: String?
        if let error = e {
            msg = error.localizedDescription
        }
        let alert = UIAlertController(title: "Erreur", message: msg ?? "Oups il semble y avoir un problème avec ta carte !", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Annuler", style: .destructive, handler: { _ in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
}
