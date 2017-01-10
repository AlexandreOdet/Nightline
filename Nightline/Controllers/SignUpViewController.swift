//
//  SignUpViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 11/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import SnapKit
import RealmSwift
import Rswift

class SignupViewController: BaseViewController {
  
  let signupButton = UIButton()
  let emailTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
  let nicknameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
  let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = R.string.localizable.sign_up()
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      addBottomButton()
      initAllFields()
    }
  }
  
  private func initAllFields() {
    
    let stackViewSignUp = UIStackView()
    stackViewSignUp.axis = .vertical
    stackViewSignUp.spacing = AppConstant.UI.Dimensions.formElementsSpacing
    
    self.view.addSubview(stackViewSignUp)
    stackViewSignUp.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    stackViewSignUp.translatesAutoresizingMaskIntoConstraints = false
    
    emailTextField.backgroundColor = UIColor.black
    emailTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.email(),
                                                              attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    emailTextField.highlightBottom()
    emailTextField.textColor = self.getAccentColor()
    emailTextField.textAlignment = .center
    
    nicknameTextField.backgroundColor = UIColor.black
    nicknameTextField.attributedPlaceholder = NSAttributedString(string:R.string.localizable.nickname(),
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    nicknameTextField.highlightBottom()
    nicknameTextField.textColor = self.getAccentColor()
    nicknameTextField.textAlignment = .center
    
    passwordTextField.backgroundColor = UIColor.black
    passwordTextField.attributedPlaceholder = NSAttributedString(string:R.string.localizable.password(),
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    passwordTextField.highlightBottom()
    passwordTextField.textColor = self.getAccentColor()
    passwordTextField.textAlignment = .center
    passwordTextField.isSecureTextEntry = true
    
    stackViewSignUp.addArrangedSubview(emailTextField)
    stackViewSignUp.addArrangedSubview(nicknameTextField)
    stackViewSignUp.addArrangedSubview(passwordTextField)
  }
  
  private func addBottomButton() {
    self.view.addSubview(signupButton)
    signupButton.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo((self.navigationController?.navigationBar.frame.height)!)
      make.width.equalTo(self.view)
    }
    signupButton.translatesAutoresizingMaskIntoConstraints = false
    signupButton.backgroundColor = self.getAccentColor()
    signupButton.setTitle(R.string.localizable.sign_up().uppercased(), for: .normal)
    signupButton.addTarget(self, action: #selector(showHomeScreen), for: .touchUpInside)
  }
  
  func showHomeScreen() {
    if !((emailTextField.text?.isEmpty)!) && !(passwordTextField.text?.isEmpty)! && !(nicknameTextField.text?.isEmpty)! {
      log.info("Sign up OK")
      keychain.set("AAAA", forKey: "token")
      DatabaseHandler().insertInDatabase(object: DbUser.self, properties: ["email":emailTextField.text!,
                                                                           "passwd":passwordTextField.text!,
                                                                           "nickname":nicknameTextField.text!])
      self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    else {
      log.error("Sign up fail")
      let alert = UIAlertController(title: R.string.localizable.error(), message: R.string.localizable.connection_fail(), preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
}
