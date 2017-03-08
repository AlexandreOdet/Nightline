
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
  
  
  // General view
  let profileView = UIView()
  
  // Header left
  let headerLeft = UIView()
  let userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  
  // Header right
  let headerRight = UIView()
  let pseudoLabel = UILabel()
  
  // Body left
  let bodyLeft = UIView()
  let legendStackView = UIStackView()
  let name = UILabel()
  let age = UILabel()
  let city = UILabel()
  
  // Body right
  let bodyRight = UIView()
  let userInfoStackView = UIStackView()
  let userNameLabel = UILabel()
  let userAgeLabel = UILabel()
  let userCityLabel = UILabel()
  
  //useless ?
  let logoutButton = UIButton()
  let editProfileButton = UIButton()
  
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
  }
  
  private func addComponentsToView() {
    initProfileView()
    initHeader()
    initBody()
  }
  
  private func initProfileView() {
    self.view.addSubview(profileView)
    profileView.snp.makeConstraints { (make) -> Void in
      make.bottom.right.left.equalToSuperview()
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
      make.bottom.equalTo(self.view).offset(-(self.tabBarController?.tabBar.frame.height)!)
    }
    profileView.translatesAutoresizingMaskIntoConstraints = false
    profileView.backgroundColor = self.getMidnightBlue()
  }
  
  private func initHeader() {
    self.profileView.addSubview(headerLeft)
    headerLeft.snp.makeConstraints { (make) -> Void in
      make.left.top.equalTo(profileView)
      make.width.equalTo(self.profileView).multipliedBy(0.5)
      make.height.equalTo(self.profileView.snp.height).multipliedBy(0.4)
    }
    
    self.profileView.addSubview(headerRight)
    headerRight.snp.makeConstraints { make in
      make.right.top.equalTo(profileView)
      make.width.equalTo(self.profileView).multipliedBy(0.5)
      make.height.equalTo(self.profileView.snp.height).multipliedBy(0.4)
    }
    
    self.headerLeft.addSubview(userProfilePicture)
    userProfilePicture.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.headerLeft.snp.center)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
    userProfilePicture.backgroundColor = UIColor.white
    userProfilePicture.image = UserManager.instance.getUserGender().image
    
    headerRight.addSubview(pseudoLabel)
    pseudoLabel.snp.makeConstraints { make in
     make.center.equalTo(self.headerRight)
    }
    pseudoLabel.text = UserManager.instance.getUserNickname()
    pseudoLabel.textColor = self.getAccentColor()
    pseudoLabel.textAlignment = .center
    pseudoLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
  }
  
  private func initBody() {
    self.profileView.addSubview(bodyLeft)
    bodyLeft.snp.makeConstraints { make in
      make.left.equalTo(profileView)
      make.top.equalTo(self.headerLeft.snp.bottom)
      make.height.equalTo(profileView.snp.height).multipliedBy(0.5)
      make.width.equalTo(profileView.snp.width).multipliedBy(0.5)
    }
    
    self.profileView.addSubview(bodyRight)
    bodyRight.snp.makeConstraints { make in
      make.right.equalTo(profileView)
      make.top.equalTo(self.headerLeft.snp.bottom)
      make.height.equalTo(profileView.snp.height).multipliedBy(0.5)
      make.width.equalTo(profileView.snp.width).multipliedBy(0.5)
    }

    addLegend()
    addUserInformations()
  }
  
  private func addLegend() {
    self.bodyLeft.addSubview(legendStackView)
    legendStackView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.bodyLeft)
      make.width.equalTo(self.bodyLeft).offset(-10)
    }
    self.legendStackView.translatesAutoresizingMaskIntoConstraints = false
    self.legendStackView.axis = .vertical
    self.legendStackView.spacing = 20
    name.text = "Name :"
    styleLegend(label: name)
    age.text = "Age :"
    styleLegend(label: age)
    city.text = "City :"
    styleLegend(label: city)
    legendStackView.addArrangedSubview(name)
    legendStackView.addArrangedSubview(age)
    legendStackView.addArrangedSubview(city)
  }
  
  private func addUserInformations() {
    self.bodyRight.addSubview(userInfoStackView)
    userInfoStackView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.bodyRight)
      make.width.equalTo(self.bodyRight).offset(-10)
    }
    
    userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    userInfoStackView.axis = .vertical
    userInfoStackView.spacing = 20
    
    userNameLabel.text = UserManager.instance.getUserCompleteName()
    userAgeLabel.text = UserManager.instance.getUserAge()
    userCityLabel.text = UserManager.instance.getUserCity()
    
    styleUserInfo(label: userNameLabel)
    styleUserInfo(label: userAgeLabel)
    styleUserInfo(label: userCityLabel)
    userInfoStackView.addArrangedSubview(userNameLabel)
    userInfoStackView.addArrangedSubview(userAgeLabel)
    userInfoStackView.addArrangedSubview(userCityLabel)
  }
  
  
  private func styleUserInfo(label: UILabel) {
    label.font = UIFont(name:"HelveticaNeue-Medium", size: 18.0)
    label.textAlignment = .left
    label.textColor = self.getAccentColor()
  }
  
  private func styleLegend(label: UILabel) {
    label.font = UIFont(name:"HelveticaNeueLight", size: 18.0)
    label.textAlignment = .right
    label.textColor = self.getAccentColor()
  }
  
  func goToEditProfilViewController() {
    let nextViewController = EditProfileViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
}
