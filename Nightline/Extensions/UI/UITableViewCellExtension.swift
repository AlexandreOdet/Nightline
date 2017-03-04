//
//  UITableViewCellExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

/**
 Extension of UITableViewCell class.
 
 Add onClick() method to animate the cell background when clicked.
 
 @param No param needed.
 
 @return Nothing.
 */

extension UITableViewCell {
  func onClick() {
    Animation().onClick(sender: self.contentView)
  }
}
