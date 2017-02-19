//
//  UITextFieldExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

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
