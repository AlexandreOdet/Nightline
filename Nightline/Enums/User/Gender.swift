//
//  Gender.swift
//  Nightline
//
//  Created by Odet Alexandre on 22/10/2016.
//  Copyright © 2016 Odet Alexandre. All rights reserved.
//

import Foundation
import Rswift

/*
 Enum: Gender
 All values possible for the user's gender.
 */

enum Gender: String {
  case male = "male"
  case female = "female"
  
  /*
   Initializer of gender enum.
   @param: String containing the gender of the user
   */
  init(gender: String) {
    switch gender {
    case "female":
      self = .female
    default:
      self = .male
    }
  }
  
  /*
   toString method of the gender enum.
   @param: None
   @return: String containing the gender of the user
   */

  func toString() -> String {
    switch self {
    case .female:
      return R.string.localizable.female()
    default:
      return R.string.localizable.male()
    }
  }
}
