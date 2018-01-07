//
//  PartyPartyID.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyPartyID: Mappable {
  
  var id:Int = 0
  
  func mapping(map: Map) {
    id <- map["id"]
  }
  
  required init?(map: Map) {
    
  }
  
  init() {}
}
