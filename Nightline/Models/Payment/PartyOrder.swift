//
//  PartyOrder.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyOrder: Mappable {
  var price: Float = 0
  var currentParty: PartyPartyID = PartyPartyID()
  var users: [PartyUser] = []
  var consos: [PartyConsommable] = []
  
  init() {}
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
      price <- map["price"]
    currentParty <- map["soiree"]
    users <- map["users"]
    consos <- map["consos"]
  }
}
