//
//  Owner.swift
//  Nightline
//
//  Created by Odet Alexandre on 27/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Owner : Mappable {
  var id: Int!
  var email: String!
  var pseudo: String!
  var passwd: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    email <- map["email"]
    pseudo <- map["pseudo"]
    passwd <- map["password"]
  }
}
