//
//  PartyPreview.swift
//  Nightline
//
//  Created by Odet Alexandre on 23/08/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyPreview: Mappable {
  
  var idParty: Int!
  var idUser: Int!
  var token: Int!
  
  required init?(map: Map) {}
  
  func mapping(map: Map) {
    idParty <- map["soireeID"]
    idUser <- map["userID"]
    token <- map["token"]
  }
  
  init() {}
}
