//
//  PartyUsers.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyUsers: Mappable {

  var users: [PartyUser] = []
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    users <- map["users"]
  }
  
  init() {}
}
