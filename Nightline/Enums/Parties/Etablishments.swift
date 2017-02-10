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
  
  func toString() -> String {
    switch self {
    case .bar:
      return R.string.localizable.bar()
    case .pub:
      return R.string.localizable.pub()
    case .lounge:
      return R.string.localizable.lounge()
    case .club:
      return R.string.localizable.club()
    default:
      return ""
    }
  }
  
  func getAllEtablishmentType() -> [Etablishment] {
    var array = Array<Etablishment>()
    array.append(Etablishment.pub)
    array.append(Etablishment.bar)
    array.append(Etablishment.lounge)
    array.append(Etablishment.club)
    return array
  }
}
