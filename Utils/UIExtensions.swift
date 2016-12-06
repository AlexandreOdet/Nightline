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
}

