//
//  ViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 02/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {
  
  let buttonSignup = UIButton()
  let buttonSignin = UIButton()
  let imgNightline = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  
  private func addLogoToView() {
    self.view.addSubview(imgNightline)
    imgNightline.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    imgNightline.translatesAutoresizingMaskIntoConstraints = false
    imgNightline.image = R.image.logo()
  }
  
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
  
  func goToSignUp(sender: UIButton) {
    let nextViewController = SignupViewController()
    self.present(nextViewController, animated: true, completion: { Void in
      self.dismiss(animated: true, completion: nil)
    })
  }
  
  func goToSignIn(sender: UIButton) {
    let nextViewController = SigninViewController()
    self.present(nextViewController, animated: true, completion: { Void in
      self.dismiss(animated: true, completion: nil)
    })
  }
  
}

