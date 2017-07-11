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
  var name = ""
  var title = ""
  var points = -1
  var description = ""
  var status : AchievementStatus = .lock
  
  init(image: UIImageView, title: String,
       points: Int, name: String, description: String) {
    self.name = name
    self.img = image
    self.title = title
    self.points = points
    self.description = description
    self.status = .lock
  }
  
  init(other: Achievement) {
    self.name = other.name
    self.img = other.img
    self.title = other.title
    self.points = other.points
    self.description = other.description
    self.status = other.status
  }
}

enum AchievementStatus {
  case lock
  case unlock
  var value: Bool {
    switch self {
    case .lock:
      return false
    default:
      return true
    }
  }
}
