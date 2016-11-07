//
//  ViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 02/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

  let buttonSignup = UIButton()
  let buttonSignin = UIButton()
  let imgNightline = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addLogoToView()
    addButtonsToView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func addLogoToView() {
    self.view.addSubview(imgNightline)
    imgNightline.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    imgNightline.translatesAutoresizingMaskIntoConstraints = false
    imgNightline.image = UIImage(named: "logo")
  }
  
  private func addButtonsToView() {
    self.view.addSubview(buttonSignup)
    buttonSignup.snp.makeConstraints { (make) -> Void in
      make.bottom.equalTo(self.view)
      make.height.equalTo((self.navigationController?.navigationBar.frame.height)!)
      make.width.equalTo(self.view)
    }
    buttonSignup.translatesAutoresizingMaskIntoConstraints = false
    buttonSignup.backgroundColor = Utils.UI.getAccentColor()
    buttonSignup.setTitle("Sign up".uppercased(), for: .normal)
    buttonSignup.addTarget(self, action: #selector(goToSignUp(sender:)), for: .touchUpInside)
    
    self.view.addSubview(buttonSignin)
    buttonSignin.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(buttonSignup)
      make.width.equalTo(buttonSignup)
      make.bottom.equalTo(buttonSignup.snp.top)
    }
    buttonSignin.translatesAutoresizingMaskIntoConstraints = false
    buttonSignin.backgroundColor = Utils.UI.getPurpleColor()
    buttonSignin.setTitle("Sign in".uppercased(), for: .normal)
    buttonSignin.addTarget(self, action: #selector(goToSignIn(sender:)), for: .touchUpInside)
  }
  
  func goToSignUp(sender: UIButton) {
    let nextViewController = SignupViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
  func goToSignIn(sender: UIButton) {
    let nextViewController = SigninViewController()
    self.navigationController?.pushViewController(nextViewController, animated: true)
  }
  
}

