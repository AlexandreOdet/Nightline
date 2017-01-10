//
//  Gender.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import Rswift

enum Gender: String {
  case male = "male"
  case female = "female"
  
  init(gender: String) {
    switch gender {
    case "female":
      self = .female
    default:
      self = .male
    }
  }
  
  func toString() -> String {
    switch self {
    case .female:
      return R.string.localizable.female()
    default:
      return R.string.localizable.male()
    }
  }
}
