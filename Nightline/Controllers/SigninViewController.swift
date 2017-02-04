//
//  SigninViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 11/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Rswift

class SigninViewController: BaseViewController {
  
  private let signinButton = UIButton()
  private let forgotPasswordLabel = UILabel()
  private let stackViewSignIn = UIStackView()
  private let nicknameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
  private let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    self.title = R.string.localizable.sign_in()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.backgroundColor = UIColor.black
      initBottomButton()
      initForgotPasswordLabel()
      initStackView()
      initNightlineLogo()
    }
  }
  private func initStackView() {
    self.view.addSubview(stackViewSignIn)
    stackViewSignIn.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    stackViewSignIn.translatesAutoresizingMaskIntoConstraints = false
    stackViewSignIn.axis = .vertical
    stackViewSignIn.spacing = AppConstant.UI.Dimensions.formElementsSpacing
    
    
    nicknameTextField.backgroundColor = UIColor.black
    nicknameTextField.attributedPlaceholder = NSAttributedString(string:R.string.localizable.nickname(),
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    nicknameTextField.highlightBottom()
    nicknameTextField.textColor = self.getAccentColor()
    nicknameTextField.textAlignment = .center
    
    passwordTextField.backgroundColor = UIColor.black
    passwordTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.password(),
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    passwordTextField.highlightBottom()
    passwordTextField.textColor = self.getAccentColor()
    passwordTextField.textAlignment = .center
    passwordTextField.isSecureTextEntry = true
    
    stackViewSignIn.addArrangedSubview(nicknameTextField)
    stackViewSignIn.addArrangedSubview(passwordTextField)
  }
  
  private func initForgotPasswordLabel() {
    self.view.addSubview(forgotPasswordLabel)
    forgotPasswordLabel.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(signinButton.snp.top).offset(-15)
      make.centerX.equalTo(self.view)
    }
    forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordLabel.text = R.string.localizable.passwd_forgot()
    forgotPasswordLabel.textColor = self.getAccentColor()
    forgotPasswordLabel.backgroundColor = UIColor.clear
  }
  
  private func initBottomButton() {
    self.view.addSubview(signinButton)
    signinButton.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo((self.navigationController?.navigationBar.frame.height)!)
      make.width.equalTo(self.view)
    }
    signinButton.translatesAutoresizingMaskIntoConstraints = false
    signinButton.backgroundColor = self.getAccentColor()
    signinButton.setTitle(R.string.localizable.sign_in().uppercased(), for: .normal)
    signinButton.addTarget(self, action: #selector(showHomeScreen), for: .touchUpInside)
  }
  
  private func initNightlineLogo() {
    let nightlineLogo = UIImageView()
    
    self.view.addSubview(nightlineLogo)
    nightlineLogo.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(stackViewSignIn.snp.top).offset(-25)
      make.centerX.equalTo(self.view)
      make.size.equalTo(20)
    }
    nightlineLogo.translatesAutoresizingMaskIntoConstraints = false
    nightlineLogo.image = R.image.logo()
  }
  
  func showHomeScreen() {
    let array = DatabaseHandler().getObjectArray(ofType: DbUser.self)
    var isConnectionOk = false
    for user in array {
      isConnectionOk = user.areUserIdOk(nickname: self.nicknameTextField.text!, passwd: self.passwordTextField.text!)
      if isConnectionOk == true {
        log.info("Sign in OK")
        if keychain.get("token") == nil {
          keychain.set("AAAA", forKey: "token")
        }
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
      }
    }
    if isConnectionOk == false {
      log.error("Sign in fail")
      let alert = UIAlertController(title: R.string.localizable.error(), message: R.string.localizable.connection_fail(), preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
}
