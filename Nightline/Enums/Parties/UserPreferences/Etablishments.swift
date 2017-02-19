//
//  Etablishments.swift
//  Nightline
//
//  Created by Odet Alexandre on 09/02/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation

enum Etablishment: String {
  case pub = "pub"
  case bar = "bar"
  case lounge = "lougne"
  case club = "club"
  case unknown = ""
  
  func getAllEtablishmentType() -> [Etablishment] {
    var array = Array<Etablishment>()
    array.append(Etablishment.pub)
    array.append(Etablishment.bar)
    array.append(Etablishment.lounge)
    array.append(Etablishment.club)
    return array
  }
}
