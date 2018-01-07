//
//  PartyConsommable.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class PartyConsommable: Mappable {
  
  var consos: Consommable!
  var amount = 0
  
  required init?(map: Map) {
    
  }
  
  init() {}
  
  func mapping(map: Map) {
    consos <- map["conso"]
    amount <- map["amount"]
  }
}
