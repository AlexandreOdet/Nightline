//
//  UIImageViewExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

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
