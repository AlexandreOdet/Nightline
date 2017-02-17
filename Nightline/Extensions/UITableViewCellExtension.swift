//
//  UITableViewCellExtension.swift
//  Nightline
//
//  Created by Odet Alexandre on 17/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
  func onClick() {
    Animation().onClick(sender: self.contentView)
  }
}
