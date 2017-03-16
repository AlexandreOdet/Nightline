//
//  ViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 02/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import UIKit
import SnapKit

/*
 Controllers: HomeViewController
 This controller is shown when user launches the app for the first time, or when he logouts from it.
 */

final class HomeViewController: BaseViewController {
  
  let buttonSignup = UIButton()
  let buttonSignin = UIButton()
  let imgNightline = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let backgroundImage = UIImageView(image: R.image.background())
    self.view.addSubview(backgroundImage)
    backgroundImage.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view)
    }
    if Utils.Network.isInternetAvailable() == false {
      self.showNoConnectivityView()
    } else {
      addLogoToView()
      addButtonsToView()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  /*
   addLogoToView() func
   This func add Nightline's logo into self.view.
   @param None.
   @return None.
   */
  
  private func addLogoToView() {
    self.view.addSubview(imgNightline)
    imgNightline.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    imgNightline.translatesAutoresizingMaskIntoConstraints = false
    imgNightline.image = R.image.logo()
  }
  
  /*
   addButtonsToView() func.
   This function add the 2 bottom buttons into self.view.
   @param None
   @return None
   */
  
  private func addButtonsToView() {
    self.view.addSubview(buttonSignup)
    buttonSignup.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo(50)
      make.width.equalTo(self.view)
    }
    buttonSignup.translatesAutoresizingMaskIntoConstraints = false
    buttonSignup.backgroundColor = self.getAccentColor()
    buttonSignup.setTitle(R.string.localizable.sign_up().uppercased(), for: .normal)
    buttonSignup.addTarget(self, action: #selector(goToSignUp(sender:)), for: .touchUpInside)
    
    self.view.addSubview(buttonSignin)
    buttonSignin.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(buttonSignup)
      make.width.equalTo(buttonSignup)
      make.bottom.equalTo(buttonSignup.snp.top)
    }
    buttonSignin.translatesAutoresizingMaskIntoConstraints = false
    buttonSignin.backgroundColor = self.getPurpleColor()
    buttonSignin.setTitle(R.string.localizable.sign_in().uppercased(), for: .normal)
    buttonSignin.addTarget(self, action: #selector(goToSignIn(sender:)), for: .touchUpInside)
  }
  
  /*
   goToSignUp(sender: UIButton) func.
   This function is called when user clicks on the sign up button.
   It displays the SignUpViewController.
   @param sender: UIButton, button clicked.
   @return None.
   */
  
  func goToSignUp(sender: UIButton) {
    let nextViewController = SignupViewController()
    self.present(nextViewController, animated: true, completion: nil)
  }
  
  /*
   goToSignIn(sender: UIButton) func.
   This function is called when user clicks on the sign in button.
   It displays the SignInViewController.
   @param sender: UIButton, button clicked.
   @return None.
   */
  
  func goToSignIn(sender: UIButton) {
    let nextViewController = SigninViewController()
    self.present(nextViewController, animated: true, completion: nil)
  }
  
}

