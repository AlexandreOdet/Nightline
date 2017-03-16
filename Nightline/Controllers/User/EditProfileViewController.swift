//
//  EditProfileViewController.swift
//  Nightline
//
//  Created by cedric moreaux on 07/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController, UITextFieldDelegate {
  
  // Global view
  let containerView = UIView()
  let scrollView = UIScrollView()
  let contentView = UIView()
  
  // Header View
  let headerView = UIView()
  let userProfilePicture = UIImageView(frame: CGRect(x: 0, y: 0, width: AppConstant.UI.Dimensions.thumbnailPictureSize, height: AppConstant.UI.Dimensions.thumbnailPictureSize))
  
  // Body View
  let bodyView = UIView()
    // Right side
  let userInfoStackView = UIStackView()
  let userName = UITextField()
  let userLastName = UITextField()
  let userAge = UITextField()
  let userCity = UITextField()
  let userNickName = UITextField()
  
    // Left side
  let instructionStackView = UIStackView()
  let firstNameLabel = UILabel()
  let lastNameLabel = UILabel()
  let ageLabel = UILabel()
  let cityLabel = UILabel()
  let nickNameLabel = UILabel()
  
  // Other
  var kbHeight: CGFloat! = nil
  var isKeyboardUp = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userName.delegate = self
    userLastName.delegate = self
    userAge.delegate = self
    userCity.delegate = self
    userNickName.delegate = self
    self.hideKeyboardWhenTappedAround()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.initView()
    }
    
  }
  
  // Global view
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
  
  // Header view
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
  
  // Body view
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
    
    // Body left side view
    self.bodyView.addSubview(userInfoStackView)
    userInfoStackView.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(bodyView)
      make.centerX.equalTo(bodyView).multipliedBy(1.3)
      make.width.equalTo(containerView).multipliedBy(0.6)
    }
    userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    userInfoStackView.axis = .vertical
    userInfoStackView.spacing = 20
    userName.text = UserManager.instance.getUserFirstName()
    userLastName.text = UserManager.instance.getUserLastName()
    userAge.text = UserManager.instance.getUserAge()
    userCity.text = UserManager.instance.getUserCity()
    userNickName.text = UserManager.instance.getUserNickname()
    styleEditField(field: userName)
    styleEditField(field: userLastName)
    styleEditField(field: userAge)
    styleEditField(field: userCity)
    styleEditField(field: userNickName)
    userInfoStackView.addArrangedSubview(userNickName)
    userInfoStackView.addArrangedSubview(userName)
    userInfoStackView.addArrangedSubview(userLastName)
    userInfoStackView.addArrangedSubview(userAge)
    userInfoStackView.addArrangedSubview(userCity)
    
    // Body right side view
    self.bodyView.addSubview(instructionStackView)
    instructionStackView.snp.makeConstraints { make in
      make.centerY.equalTo(userInfoStackView)
      make.height.equalTo(userInfoStackView)
      make.centerX.equalTo(bodyView).multipliedBy(0.3)
      make.width.equalTo(containerView).multipliedBy(0.3)
    }
    instructionStackView.translatesAutoresizingMaskIntoConstraints = false
    instructionStackView.axis = .vertical
    instructionStackView.spacing = 22
    firstNameLabel.text = "First name:"
    lastNameLabel.text = "Last name:"
    ageLabel.text = "Age:"
    cityLabel.text = "City:"
    nickNameLabel.text = "Nickname:"
    styleInstruction(label: firstNameLabel)
    styleInstruction(label: lastNameLabel)
    styleInstruction(label: ageLabel)
    styleInstruction(label: cityLabel)
    styleInstruction(label: nickNameLabel)
    instructionStackView.addArrangedSubview(nickNameLabel)
    instructionStackView.addArrangedSubview(firstNameLabel)
    instructionStackView.addArrangedSubview(lastNameLabel)
    instructionStackView.addArrangedSubview(ageLabel)
    instructionStackView.addArrangedSubview(cityLabel)
  }
  
  // Style label right side
  private func styleInstruction(label: UILabel) {
    label.textColor = self.getAccentColor()
    label.font = UIFont(name:"HelveticaNeueLight", size: 18.0)
    label.textAlignment = .right
  }
  
  // Style textfield left side
  private func styleEditField(field: UITextField) {
    field.font = UIFont(name:"HelveticaNeue-Medium", size: 18.0)
    field.textColor = UIColor.init(hex: 0xFF7F40)
    field.textAlignment = .center
    field.backgroundColor = UIColor.init(hex: 0x233157)
    field.layer.cornerRadius = 5.0
    field.textAlignment = .center
  }
  
  // Save value before go to previews view
  override func viewWillDisappear(_ animated: Bool) {
    UserManager.instance.updateUserFirstName(newValue: userName.text!)
    UserManager.instance.updateUserLasttName(newValue: userLastName.text!)
    UserManager.instance.updateUserAge(newValue: userAge.text!)
    UserManager.instance.updateUserCity(newValue: userCity.text!)
    UserManager.instance.updateUserNickName(newValue: userNickName.text!)
    NotificationCenter.default.removeObserver(self)
  }
  
  // Go to previous view
  func comeBackToProfileViewController() {
    let nextViewController = UserProfileViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  /*
   viewWillAppear() func.
   This function set up Observer for keyboard appearing and disappearing.
   @param animated: Bool
   @return None
   */
  override func viewWillAppear(_ animated:Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  
  /*
   keyboardWillShow() func.
   This function handle the keyboard appear notification, calculate the size of keyboard and call animateTextField().
   @param notification
   @return None
   */
  @objc func keyboardWillShow(notification: NSNotification) {
    if let userInfo = notification.userInfo {
      if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        kbHeight = keyboardSize.height
        self.animateTextField(up: true)
      }
    }
  }
  
  /*
   keyboardWillHide() func.
   This function handle the keyboard disappear notification.
   @param notification
   @return None
   */
  @objc func keyboardWillHide(notification: NSNotification) {
    self.animateTextField(up: false)
  }
  
  /*
   animateTextField() func.
   This function determine if the keyboard will hide the textfields.
   @param up: keyboard will appear (true) or disappear (false)
   @return None
   */
    func animateTextField(up: Bool) {
    var movement = kbHeight
    if (up == true && isKeyboardUp == true) {
      movement = 0
    } else if (up == true && isKeyboardUp == false) {
      movement = -kbHeight
      isKeyboardUp = true
    } else {
      movement = kbHeight
      isKeyboardUp = false
    }
    UIView.animate(withDuration: 0.3, animations: {
      self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
    })
  }
  
}
