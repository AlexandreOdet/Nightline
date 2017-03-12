//
//  EditProfileViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {
  
  // Global view
  let containerView = UIView()
  let scrollView = UIScrollView()
  let contentView = UIView()
  
  // Header View
  let headerView = UIView()
  let userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  
  // Body View
  let bodyView = UIView()
  let userInfoStackView = UIStackView()
  let userNameLabel = UILabel()
  let userLastNameLabel = UILabel()
  let ageLabel = UILabel()
  let cityLabel = UILabel()
  let nickNameLabel = UILabel()
  let userName = UITextField()
  let userLastName = UITextField()
  let userAge = UITextField()
  let userCity = UITextField()
  let userNickName = UITextField()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.initView()
    }
    
  }
  
  private func initView() {
    self.view.addSubview(containerView)
    containerView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
      make.left.right.bottom.equalTo(self.view)
    }
    self.containerView.addSubview(scrollView)
    scrollView.snp.makeConstraints { make in
      make.edges.equalTo(containerView)
    }
    self.scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { make in
      make.edges.equalTo(scrollView)
    }
    scrollView.alwaysBounceVertical = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.backgroundColor = self.getMidnightBlue()
    
    initHeaderView()
    initBodyView()
  }
  
  private func initHeaderView() {
    self.contentView.addSubview(headerView)
    headerView.snp.makeConstraints { make in
      make.left.right.top.equalTo(contentView)
      make.height.equalTo(self.containerView.snp.height).multipliedBy(0.3)
      make.centerX.equalTo(containerView)
    }
    self.headerView.addSubview(userProfilePicture)
    userProfilePicture.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.headerView)
      make.size.equalTo(AppConstant.UI.Dimensions.thumbnailPictureSize)
    }
    userProfilePicture.translatesAutoresizingMaskIntoConstraints = false
    userProfilePicture.roundImage()
    userProfilePicture.image = R.image.logo()
  }
  
  private func initBodyView() {
      self.contentView.addSubview(bodyView)
    bodyView.snp.makeConstraints { make in
      make.top.equalTo(self.userProfilePicture.snp.bottom)
      make.right.left.equalTo(contentView)
      make.centerX.equalTo(containerView)
      make.bottom.equalTo(scrollView)
      make.height.greaterThanOrEqualTo(containerView).multipliedBy(0.7)
      make.width.equalTo(containerView)
    }
    self.bodyView.addSubview(userInfoStackView)
    userInfoStackView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(bodyView)
    }
    userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    userInfoStackView.axis = .vertical
    userInfoStackView.spacing = 10
    
    userNameLabel.text = "First name:"
    userLastNameLabel.text = "Last name:"
    ageLabel.text = "Age:"
    cityLabel.text = "City:"
    nickNameLabel.text = "Nickname:"
    
    userName.text = UserManager.instance.getUserFirstName()
    userLastName.text = UserManager.instance.getUserLastName()
    userAge.text = UserManager.instance.getUserAge()
    userCity.text = UserManager.instance.getUserCity()
    userNickName.text = UserManager.instance.getUserNickname()
    
    styleLegend(label: userNameLabel)
    styleEditField(field: userName)
    userLastNameLabel.textColor = self.getAccentColor()
    userLastNameLabel.textAlignment = .left
    userLastName.textColor = self.getAccentColor()
    userLastName.styleEditField()
    ageLabel.textColor = self.getAccentColor()
    ageLabel.textAlignment = .left
    userAge.textColor = self.getAccentColor()
    userAge.styleEditField()
    userAge.keyboardType = UIKeyboardType.numberPad
    cityLabel.textColor = self.getAccentColor()
    cityLabel.textAlignment = .left
    userCity.textColor = self.getAccentColor()
    userCity.styleEditField()
    nickNameLabel.textColor = self.getAccentColor()
    nickNameLabel.textAlignment = .left
    userNickName.textColor = self.getAccentColor()
    userNickName.styleEditField()
    userInfoStackView.addArrangedSubview(nickNameLabel)
    userInfoStackView.addArrangedSubview(userNickName)
    userInfoStackView.addArrangedSubview(userNameLabel)
    userInfoStackView.addArrangedSubview(userName)
    userInfoStackView.addArrangedSubview(userLastNameLabel)
    userInfoStackView.addArrangedSubview(userLastName)
    userInfoStackView.addArrangedSubview(ageLabel)
    userInfoStackView.addArrangedSubview(userAge)
    userInfoStackView.addArrangedSubview(cityLabel)
    userInfoStackView.addArrangedSubview(userCity)
  }
  

  private func styleLegend(label: UILabel) {
    userNameLabel.textColor = self.getAccentColor()
    userNameLabel.textAlignment = .left
  }
  
  private func styleEditField(field: UITextField) {
    field.textColor = self.getAccentColor()
    field.textAlignment = .center
    field.backgroundColor = UIColor.gray
    field.layer.cornerRadius = 5.0
    field.textAlignment = .center
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    UserManager.instance.updateUserFirstName(newValue: userName.text!)
    UserManager.instance.updateUserLasttName(newValue: userLastName.text!)
    UserManager.instance.updateUserAge(newValue: userAge.text!)
    UserManager.instance.updateUserCity(newValue: userCity.text!)
    UserManager.instance.updateUserNickName(newValue: userNickName.text!)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  func comeBackToProfileViewController() {
    let nextViewController = UserProfileViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  
}
