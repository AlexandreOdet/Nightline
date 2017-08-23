//
//  OrderParty.swift
//  Nightline
//
//  Created by Odet Alexandre on 23/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderParty: Mappable {
  
  var userID: Int!
  var partyID: Int!
  var consoID: Int!
  var token: Int!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    userID <- map["userID"]
    partyID <- map["soireeID"]
    consoID <- map["consoID"]
    token <- map["token"]
  }
}
