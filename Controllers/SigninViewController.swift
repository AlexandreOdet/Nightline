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

class SigninViewController: BaseViewController {
  
  private let signinButton = UIButton()
  private let forgotPasswordLabel = UILabel()
  private let stackViewSignIn = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Sign in"
    self.view.backgroundColor = UIColor.black
    initBottomButton()
    initForgotPasswordLabel()
    initStackView()
    initNightlineLogo()
  }
  
  private func initStackView() {
    let nicknameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    
    self.view.addSubview(stackViewSignIn)
    stackViewSignIn.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    stackViewSignIn.translatesAutoresizingMaskIntoConstraints = false
    stackViewSignIn.axis = .vertical
    stackViewSignIn.spacing = AppConstant.UI.Dimensions.formElementsSpacing
    
    
    nicknameTextField.backgroundColor = UIColor.black
    nicknameTextField.attributedPlaceholder = NSAttributedString(string:"Nickname",
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    nicknameTextField.highlightBottom()
    nicknameTextField.textColor = self.getAccentColor()
    nicknameTextField.textAlignment = .center
    
    passwordTextField.backgroundColor = UIColor.black
    passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
                                                           attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    passwordTextField.highlightBottom()
    passwordTextField.textColor = self.getAccentColor()
    passwordTextField.textAlignment = .center
    
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
    forgotPasswordLabel.text = "Forgot Password ?"
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
    signinButton.setTitle("Sign in".uppercased(), for: .normal)
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
    nightlineLogo.image = UIImage(named: "logo")
  }
  
  func showHomeScreen() {
    self.navigationController?.pushViewController(HomeViewController(), animated: true)
  }
}
