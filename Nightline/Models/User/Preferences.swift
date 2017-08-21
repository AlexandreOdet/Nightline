//
//  Preferences.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Preferences: Mappable {
  var id: Int!
  var name: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["ID"]
    name <- map["Name"]
  }
}
