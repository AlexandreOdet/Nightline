//
//  FriendsList.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class FriendsList: Mappable {
  var friends: [User] = []
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    friends <- map["friends"]
  }
}
