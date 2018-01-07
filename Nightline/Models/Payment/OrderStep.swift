//
//  OrderStep.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderStep: Mappable {
  
  var id = 0
  var name = ""
  var result = ""
  var date = ""
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    result <- map["result"]
    date <- map["date"]
  }
  
  init() {
  }
}
