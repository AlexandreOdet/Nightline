//
//  PartyUser.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyUser: Mappable {
  
  var user: User!
  var price: Int! = 0
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    user <- map["user"]
    price <- map["price"]
  }
  
  init() {}
  
}

/*
 "user": {
 "id": 595
 },
 "price": 20
 */
