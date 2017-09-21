//
//  BaseViewController.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/12/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/*
 Controllers: BaseViewController
 This controller is like an abstract class, all the UIViewControllers use in this project will inherit from it.
 It defines some functions that'll be use often.
 */

class BaseViewController: UIViewController {
  
  var img = UIImageView()
  var label = UILabel()
  var button = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black
    createNoConnectivityView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  /*
   getPurpleColor() func.
   This function will return our custom purple color.
   @param None.
   @return UIColor: Our custom purple color.
   */
  
  func getPurpleColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.purple)
  }
  
  /*
   getPrimaryColor() func.
   This function will return our custom primary color.
   @param None.
   @return UIColor: Our custom primary color.
   */
  
  func getPrimaryColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorPrimary)
  }

  /*
   getAccentColor() func.
   This function will return our custom accent color.
   @param None.
   @return UIColor: Our custom accent color.
   */
  
  func getAccentColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.colorAccent)
  }

  /*
   getWhiteColor() func.
   This function will return our custom white color.
   @param None.
   @return UIColor: Our custom white color.
   */
  
  func getWhiteColor() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.white)
  }
  
  /*
   getMidnightBlue() func.
   This function will return our custom Midnight blue color.
   @param None.
   @return UIColor: Our custom Midnight blue color.
   */
  
  func getMidnightBlue() -> UIColor {
    return UIColor(hex: AppConstant.UI.Colors.midnightBlue)
  }
  
  /*
   createNoConnectivityView() func.
   This function creates and sets position of elements shown where there's no internet connectivity.
   @param None
   @return None
   */
  
  func createNoConnectivityView() {
    img = UIImageView(image: UIImage(named: "logo"))
    view.addSubview(img)
    img.snp.makeConstraints { (make) -> Void in
      make.center.equalToSuperview()
    }
    img.translatesAutoresizingMaskIntoConstraints = false
    img.isHidden = true
    view.addSubview(label)
    label.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(img.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
      make.centerX.equalToSuperview()
    }
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Pas de connexion internet"
    label.textAlignment = .center
    label.isHidden = true
    view.addSubview(button)
    button.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(label.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(15)
      make.trailing.equalToSuperview().offset(-15)
      make.centerX.equalToSuperview()
    }
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Réessayer", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = UIColor.lightGray
    button.isHidden = true
  }
  
  /*
   showNoConnectivityView() func.
   This function displays the no connectivity screen to current view.
   @param None
   @return None
   */
  
  func showNoConnectivityView() {
    for subview in view.subviews {
        subview.isHidden = true
    }
    view.backgroundColor = UIColor.white
    img.isHidden = false
    label.isHidden = false
    button.isHidden = false
  }
  
  /*
   hideNoConnectivityView() func.
   This function hide the no connectivity screen from current view.
   @param None
   @return None
   */
  
  func hideNoConnectivityView() {
    view.backgroundColor = UIColor.black
    img.isHidden = true
    label.isHidden = true
    button.isHidden = true
  }
}
