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
import PromiseKit
import FBSDKLoginKit

/*
 Controllers: SigninViewController.
 This controllers is displayed when user tries to log into the app.
 */

final class SigninViewController: BaseViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
  let nightlineLogo = UIImageView()
  private let signinButton = UIButton()
  private let forgotPasswordLabel = UILabel()
  private let stackViewSignIn = UIStackView()
  private let nicknameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 700, height: 20))
  private let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 700, height: 20))
  let backButton = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
  let restApiUser = RAUser()
  private let facebookReadPermissions = ["public_profile", "email", "user_friends"]
  let loginButton = FBSDKLoginButton()
  let loginManager = FBSDKLoginManager()

  
  static let notificationIdentifier = "dismissHomeViewController"
  
  
  deinit {
    restApiUser.cancelRequest()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    self.title = R.string.localizable.sign_in()
    let backgroundImage = UIImageView(image: R.image.background())
    self.view.addSubview(backgroundImage)
    backgroundImage.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    backgroundImage.alpha = 0.5
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      self.view.backgroundColor = UIColor.black
      initBottomButton()
      initForgotPasswordLabel()
      initStackView()
      initNightlineLogo()
      addBackButton()
      addFacebookButton()
    }
  }
  
  /*
   initStackView() func.
   This function sets position and content of the UIStackView used into self.view
   @param None
   @return None
   */
  
  private func initStackView() {
    self.view.addSubview(stackViewSignIn)
    stackViewSignIn.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.leading.equalTo(self.view).offset(30)
      make.trailing.equalTo(self.view).offset(-30)
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
    nicknameTextField.returnKeyType = UIReturnKeyType.next
    nicknameTextField.delegate = self
    nicknameTextField.tag = 0
    nicknameTextField.becomeFirstResponder()
    nicknameTextField.backgroundColor = .clear
    
    passwordTextField.backgroundColor = UIColor.black
    passwordTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.password(),
                                                                 attributes:[NSForegroundColorAttributeName: self.getAccentColor()])
    passwordTextField.highlightBottom()
    passwordTextField.textColor = self.getAccentColor()
    passwordTextField.textAlignment = .center
    passwordTextField.isSecureTextEntry = true
    passwordTextField.returnKeyType = UIReturnKeyType.done
    passwordTextField.delegate = self
    passwordTextField.tag = 1
    passwordTextField.backgroundColor = .clear
    
    stackViewSignIn.addArrangedSubview(nicknameTextField)
    stackViewSignIn.addArrangedSubview(passwordTextField)
  }
  
  /*
   initForgotPasswordLabel() func.
   This function sets position and content of the forgotPasswordLabel into self.view
   @param None
   @return None
   */
  
  private func initForgotPasswordLabel() {
    self.view.addSubview(forgotPasswordLabel)
    let forgotTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordAction))
    forgotTapGestureRecognizer.numberOfTapsRequired = 1
    
    forgotPasswordLabel.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(signinButton.snp.top).offset(-15)
      make.centerX.equalTo(self.view)
    }
    forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordLabel.text = R.string.localizable.passwd_forgot()
    forgotPasswordLabel.textColor = self.getAccentColor()
    forgotPasswordLabel.backgroundColor = UIColor.clear
    forgotPasswordLabel.isUserInteractionEnabled = true
    forgotPasswordLabel.addGestureRecognizer(forgotTapGestureRecognizer)
  }
  
  /*
   initBottomButton() func.
   This func sets position and content of signinButton into self.view
   @param None
   @return None
   */
  
  private func initBottomButton() {
    self.view.addSubview(signinButton)
    signinButton.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(50)
      make.bottom.equalTo(self.view)
      make.width.equalTo(self.view)
    }
    signinButton.translatesAutoresizingMaskIntoConstraints = false
    signinButton.backgroundColor = self.getAccentColor()
    signinButton.setTitle(R.string.localizable.sign_in().uppercased(), for: .normal)
    signinButton.addTarget(self, action: #selector(showHomeScreen), for: .touchUpInside)
  }
  
  /*
   initNightlineLogo() func.
   This func sets position of the Nightline's logo that'll be displayed into self.view
   @param None
   @return None
   */
  
  private func initNightlineLogo() {
    
    self.view.addSubview(nightlineLogo)
    nightlineLogo.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(stackViewSignIn.snp.top).offset(-25)
      make.centerX.equalTo(self.view)
      make.size.equalTo(150)
    }
    nightlineLogo.translatesAutoresizingMaskIntoConstraints = false
    nightlineLogo.image = R.image.logo()
    nightlineLogo.isUserInteractionEnabled = true
    
    let logoGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(animateLogo))
    logoGestureRecognizer.numberOfTapsRequired = 1
    nightlineLogo.addGestureRecognizer(logoGestureRecognizer)
  }
  
  func animateLogo() {
    Animation().bounceEffect(sender: nightlineLogo)
  }
  
  /*
   showHomeScreen() func
   This function is called when user clicks on signinButton.
   If datas typed are OK that'll save token received by server into keychain service, otherwise it shows an UIAlertController.
   @param None
   @return None
   */
  
  func showHomeScreen() {
    Utils.Network.spinnerStart()
    firstly {
      restApiUser.loginUser(email: nicknameTextField.text ?? "", password: passwordTextField.text ?? "")
      }.then {
        resp -> Void in
        print(resp.user?.toJSONString(prettyPrint: true) ?? "No user", resp.token ?? "No token")
        tokenWrapper.setToken(valueFor: resp.token!)
        self.dismiss(animated: true, completion: {
          self.presentingViewController?.dismiss(animated: true, completion: nil)})
        let notificationName = Notification.Name(SigninViewController.notificationIdentifier)
        NotificationCenter.default.post(name: notificationName, object: nil)
      }.catch { _ in
        AlertUtils.networkErrorAlert(fromController: self)
      }.always {
        Utils.Network.spinnerStop()
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      textField.resignFirstResponder()
      let newTextField = self.view.viewWithTag(textField.tag + 1)
      newTextField?.becomeFirstResponder()
    } else if textField.tag == 1 {
      self.view.endEditing(true)
      textField.resignFirstResponder()
    }
    return true
  }
  
  /*
   addBackButton() func.
   This function sets position and content of the backButton into self.view
   @param None
   @return None
   */
  
  private func addBackButton() {
    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonPressed))
    gestureRecognizer.numberOfTapsRequired = 1
    self.view.addSubview(backButton)
    backButton.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.view).offset(UIApplication.shared.statusBarFrame.height)
      make.leading.equalTo(self.view).offset(10)
      make.size.equalTo(50)
    }
    backButton.isUserInteractionEnabled = true
    backButton.translatesAutoresizingMaskIntoConstraints = false
    backButton.image = R.image.back_arrow()
    backButton.backgroundColor = UIColor.white
    backButton.roundImage(withBorder: true, borderColor: .red, borderSize: 1.0)
    backButton.addGestureRecognizer(gestureRecognizer)
  }
  
  /*
   backButtonPressed() func.
   This function is called when the backButton is pressed.
   It dismisses this controller.
   @param None
   @return None
   */
  
  func backButtonPressed() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func forgotPasswordAction() {
    var mailTextField = UITextField()
    let alertController = UIAlertController(title: "", message: R.string.localizable.type_mail(), preferredStyle: .alert)
    alertController.addTextField(configurationHandler: { (textField) in
      mailTextField = textField
      mailTextField.keyboardType = .emailAddress
      mailTextField.placeholder = R.string.localizable.email()
    })
    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
      log.debug("OK mail tapé: \(String(describing: mailTextField.text))")
    }))
    alertController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil))
    self.present(alertController, animated: true, completion: nil)
  }
  
  private func addFacebookButton() {
    loginButton.readPermissions = self.facebookReadPermissions
    loginButton.delegate = self
    self.view.addSubview(loginButton)
    loginButton.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(stackViewSignIn.snp.bottom).offset(50)
      make.leading.equalTo(self.view).offset(20)
      make.trailing.equalTo(self.view).offset(-20)
    }
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    
  }
  
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if(error == nil)
    {

      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          let fbDetails = result as! Dictionary<String, Any>
          print(fbDetails)
          firstly {
            self.restApiUser.signUpUser(email: fbDetails["email"] as! String,
                                   nickname: fbDetails["name"] as! String,
                                   password: "abcdef")
            }.then { resp -> Void in
              tokenWrapper.setToken(valueFor: resp.token!)
              self.dismiss(animated: true, completion: {
                self.presentingViewController?.dismiss(animated: true, completion: nil)})
              let notificationName = Notification.Name(SigninViewController.notificationIdentifier)
              NotificationCenter.default.post(name: notificationName, object: nil)

            }.catch { _ in
              firstly {
                self.restApiUser.loginUser(email: fbDetails["email"] as! String, password: "abcdef")
                }.then {
                  resp -> Void in
                  tokenWrapper.setToken(valueFor: resp.token!)
                  self.dismiss(animated: true, completion: {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)})
                  let notificationName = Notification.Name(SigninViewController.notificationIdentifier)
                  NotificationCenter.default.post(name: notificationName, object: nil)
                }.catch { _ in
                  self.loginManager.logOut()
                  AlertUtils.networkErrorAlert(fromController: self)
              }
          }
        } else {
          print((error?.localizedDescription)!)
        }
      })
    }
    else{
      print(error.localizedDescription)
    }
    
  }
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    //logout
    print("logout")
  }
}
