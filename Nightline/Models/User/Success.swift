//
//  Success.swift
//  Nightline
//
//  Created by Odet Alexandre on 21/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Success: Mappable {
  
  var id: Int!
  var name: String!
  var description: String!
  var points: Int!
  var isLocked: Bool!
  var icon: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["ID"]
    name <- map["Name"]
    description <- map["Description"]
    points <- map["Points"]
    isLocked <- map["Locked"]
    icon <- map["Icon"]
  }
}
