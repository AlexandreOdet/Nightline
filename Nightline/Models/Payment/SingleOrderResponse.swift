//
//  SingleOrderResponse.swift
//  Nightline
//
//  Created by Odet Alexandre on 07/01/2018.
//  Copyright © 2018 Odet Alexandre. All rights reserved.
//

import Foundation
import ObjectMapper

class SingleOrderResponse: Mappable {
  var order: OrderResponse = OrderResponse()
  
  init() {}
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    order <- map["order"]
  }
}
