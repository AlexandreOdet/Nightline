//
//  Extensions.swift
//  Nightline
//
//  Created by Odet Alexandre on 19/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(hex:Int) {
    self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:(hex & 0xff))
  }
}

extension UITextField {
  func highlightBottom() {
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor(hex: AppConstant.UI.Colors.colorAccent).cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width:  self.frame.size.width, height: width)
    
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
    
    func styleEditField() {
        self.textAlignment = .center
        self.backgroundColor = UIColor.gray
        self.layer.cornerRadius = 5.0
        self.textAlignment = .center
    }
}

extension UIImageView {
  func roundImage(withBorder: Bool = true, borderColor: UIColor = UIColor.white, borderSize: CGFloat = 1.0) {
    self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
    if withBorder == true {
      self.layer.borderWidth = borderSize
      self.layer.borderColor = borderColor.cgColor
    }
  }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

