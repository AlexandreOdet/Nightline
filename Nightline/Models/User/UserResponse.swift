//
//  UserResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 28/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class UserResponse: Mappable {
  var user: User!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    user <- map["user"]
  }
}
