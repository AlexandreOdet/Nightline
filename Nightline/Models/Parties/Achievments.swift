//
//  Achievments.swift
//  Nightline
//
//  Created by Odet Alexandre on 25/03/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import UIKit

class Achievement {
  var img = UIImageView()
  var title = ""
  var points = -1
  var description = ""
  var status = false
  
  init(image: UIImageView, title: String,
       points: Int, description: String) {
    self.img = image
    self.title = title
    self.points = points
    self.description = description
    self.status = false
  }
}
