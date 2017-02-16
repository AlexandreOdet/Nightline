
//
//  UserProfileViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

final class UserProfileViewController: BaseViewController {
  
    var userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
    var headerView = UIView()
    var userInfoStackView = UIStackView()
    var userNameLabel = UILabel()
    var userLastNameLabel = UILabel()
    var age = UILabel()
    var ville = UILabel()
    var logoutButton = UIButton()
    var editProfileButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
        self.view.backgroundColor = UIColor.black
        self.addComponentsToView()
        let rightBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToEditProfilViewController))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    addLogoutButtonToView()
  }
  
  private func addComponentsToView() {
    initHeaderView()
    addUserProfilePicture()
    addUserNameLabels()
  }
  
  private func initHeaderView() {
    self.view.addSubview(headerView)
    headerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
      make.height.equalTo(UIScreen.main.bounds.width * (9/16))
      make.width.equalTo(UIScreen.main.bounds.width)
    }
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.backgroundColor = self.getMidnightBlue()
  }
  
  private func addUserProfilePicture() {
    self.headerView.addSubview(userProfilePicture)
    userProfilePicture.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(self.headerView)
      make.leading.equalTo(self.headerView).offset(15)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
    userProfilePicture.image = R.image.logo()
  }
  
  private func addUserNameLabels() {
    self.headerView.addSubview(userInfoStackView)
    userInfoStackView.snp.makeConstraints { (make) -> Void in
      make.leading.equalTo(self.headerView.snp.centerX)
      make.trailing.equalTo(self.headerView).offset(-10)
      make.centerY.equalTo(headerView)
    }
    userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    userInfoStackView.axis = .vertical
    userInfoStackView.spacing = 10
    
    userNameLabel.text = "Alex Odet"
    age.text = "18ans"
    ville.text = "Los Angeles"
    
    userNameLabel.textColor = self.getAccentColor()
    userNameLabel.textAlignment = .center
    userLastNameLabel.textAlignment = .center
    age.textColor = self.getAccentColor()
    age.textAlignment = .center
    ville.textColor = self.getAccentColor()
    ville.textAlignment = .center
    userInfoStackView.addArrangedSubview(userNameLabel)
    userInfoStackView.addArrangedSubview(age)
    userInfoStackView.addArrangedSubview(ville)
  }
    
    private func addLogoutButtonToView() {
        self.view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(50)
        }
        logoutButton.backgroundColor = UIColor.white
        logoutButton.setTitle(R.string.localizable.logout(), for: .normal)
        logoutButton.addTarget(self, action: #selector(performLogoutAction), for: .touchUpInside)
        logoutButton.setTitleColor(.red, for: .normal)
    }
    
    func performLogoutAction() {
        self.navigationController?.popToRootViewController(animated: true)
        Utils.Network.logOutUser()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //self.navigationController?.navigationBar.barTintColor = UIColor.orange
    //self.navigationController?.navigationBar.tintColor = UIColor.black
  }
  
//  func goToUserSettingsViewController() {
//    let nextViewController = UserSettingsTableViewController()
//    self.navigationController?.pushViewController(nextViewController, animated: true)
//  }
    
    func goToEditProfilViewController() {
        let nextViewController = EditProfileViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
  
}
