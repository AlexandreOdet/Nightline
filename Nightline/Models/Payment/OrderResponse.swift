//
//  OrderResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderResponse: Mappable {
  
  var id: Int = 0
  var price: Int = 0
  var done: String = ""
  var orderParty: PartyResult = PartyResult()
  var begin = ""
  var end = ""
  var users = [PartyUser]()
  var consos = [PartyConsommable]()
  var steps = [OrderStep]()
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    done <- map["done"]
    price <- map["price"]
    orderParty <- map["soiree"]
    begin <- map["begin"]
    end <- map["end"]
    users <- map["users"]
    consos <- map["consos"]
    steps <- map["steps"]
  }
  
  init() {}
}
