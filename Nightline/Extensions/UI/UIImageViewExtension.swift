//
//  UIImageViewExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UIImageView class.
 Add roundImage() method to round your image.
 
 @param withBorder: define if you'll have a border around your UIImageView, default is true.
 @param: borderColor: define the color of you're border, default is UIColor.white
 @param: borderSize: define the size of the border. default is 1.0
 */

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
