
//
//  RateEstabResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 13/11/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class RateEstabResponse: Mappable {
  var estab: Etablissement!
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    estab <- map["estab"]
  }
}
