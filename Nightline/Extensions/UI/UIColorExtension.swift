//
//  UIColorExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UIColor class.
 
 Add a new constructor (hex: Int) to create custom colors.
 
 @param Integer on hexadecimal format (0x000000).
 
 @return a UIColor corresponding to the integer you sent.
 */

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
