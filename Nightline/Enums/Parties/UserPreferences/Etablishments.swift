//
//  Etablishments.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

/**
 Enum: Etablishment.
 Enum containing all the possibilities for the etablishment preferences.
 */

enum Etablishment: String {
  case pub = "pub"
  case bar = "bar"
  case lounge = "lougne"
  case club = "club"
  case unknown = ""
  
  /**
   Function of Consommation Enum.
   Have the array of all etablishment type available.
   
   @param: None
   @return An array with all the etablishment available.
   */
  
  func getAllEtablishmentType() -> [Etablishment] {
    var array = Array<Etablishment>()
    array.append(Etablishment.pub)
    array.append(Etablishment.bar)
    array.append(Etablishment.lounge)
    array.append(Etablishment.club)
    return array
  }
}
