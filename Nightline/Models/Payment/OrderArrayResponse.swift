//
//  OrderArrayResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class OrderArrayResponse: Mappable {
  
  var orders = [OrderResponse]()
  
  init() {}
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    orders <- map["orders"]
  }
}
