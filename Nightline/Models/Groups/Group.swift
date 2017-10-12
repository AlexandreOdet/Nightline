//
//  Group.swift
//  Nightline
//
//  Created by Odet Alexandre on 12/10/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Group: Mappable {
  
  var id: Int?
  var name: String!
  var description: String!
  var users: [User]?
  
  init() {
    id = -1
    name = ""
    description = ""
    users = []
  }
  
  required init?(map: Map) { }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    description <- map["description"]
    users <- map["users"]
  }
}
