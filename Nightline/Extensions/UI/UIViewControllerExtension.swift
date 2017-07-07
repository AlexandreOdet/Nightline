//
//  Extensions.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UIViewController class.
 
 Add hideKeyboardWhenTappedAround method to hide the keyboard when user clicks outside of the UITextField.
 
 @param No param needed.
 
 @return Nothing.
 */

extension BaseViewController {
  func backgroundColor() -> UIColor {
    return UIColor.init(hex: 0x2E1B0A)
  }
  
  func textFieldBackgroundColor() -> UIColor {
    return UIColor.init(hex: 0x331D0B)
  }
  
  func textFieldTextColor() -> UIColor {
    return UIColor.init(hex: 0xF08329)
  }
  
  func labelTextColor() -> UIColor {
    return UIColor.init(hex: 0x9C998C)
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
}

