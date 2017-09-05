//
//  Invitation.swift
//  Nightline
//
//  Created by Odet Alexandre on 05/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class Invitation: Mappable {
  
  var id: Int!
  var from: String!
  var to: String!
  var when: String!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    id <- map["id"]
    from <- map["from"]
    to <- map["to"]
    when <- map["date"]
  }
  
}

/*
 "id": 0,
 "from": "string",
 "to": "string",
 "date": "string"
 */
