//
//  BaseViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  
  var img = UIImageView()
  var label = UILabel()
  var button = UIButton()
  var refresh = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black
    createNoConnectivityView()
    self.refresh.addTarget(self, action: #selector(pullToRefreshTask), for: .valueChanged)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func getPurpleColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.purple)
  }
  
  func getPrimaryColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorPrimary)
  }

  func getAccentColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorAccent)
  }

  func getWhiteColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.white)
  }
  
  func createNoConnectivityView() {
    img = UIImageView(image: UIImage(named: "logo"))
    self.view.addSubview(img)
    img.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
    }
    img.translatesAutoresizingMaskIntoConstraints = false
    img.isHidden = true
    self.view.addSubview(label)
    label.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(img.snp.bottom).offset(10)
      make.leading.equalTo(self.view).offset(15)
      make.trailing.equalTo(self.view).offset(-15)
      make.centerX.equalTo(self.view)
    }
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Pas de connexion internet"
    label.textAlignment = .center
    label.isHidden = true
    self.view.addSubview(button)
    button.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(label.snp.bottom).offset(10)
      make.leading.equalTo(self.view).offset(15)
      make.trailing.equalTo(self.view).offset(-15)
      make.centerX.equalTo(self.view)
    }
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Réessayer", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = UIColor.lightGray
    button.isHidden = true
  }
  
  func showNoConnectivityView() {
    self.view.backgroundColor = UIColor.white
    self.img.isHidden = false
    self.label.isHidden = false
    self.button.isHidden = false
  }
  
  func hideNoConnectivityView() {
    self.view.backgroundColor = UIColor.black
    self.img.isHidden = true
    self.label.isHidden = true
    self.button.isHidden = true
  }
  
  func pullToRefreshTask() {
    
  }
  
}
